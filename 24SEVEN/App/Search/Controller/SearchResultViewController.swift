
import UIKit
import Speech

class SearchResultViewController : GenericViewController {
    let _view = SearchResultView()
    var countOfResults: Int?
    let searchResultVM = SearchResultsViewModel()
    
    var searchedQuery: String?
    var queryForNetwork: String = ""
    
    let addFavVM = AddToFavouriteViewModel()
    let removeFavVM = RemoveFromFavouriteViewModel()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru-RU"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBySpeech()
        setupCollectionView()
        setupSearchTextFieldAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self._view.searchVC.searchAndScanView.searchTextField.becomeFirstResponder()
        }
        setupSearchRecognition()
    }
    
    override func loadView() {
        view = _view
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.audioEngine.stop()
        self.recognitionRequest?.endAudio()
    }
}

extension SearchResultViewController {
    private func setupCollectionView() {
        _view.collectionView.delegate = self
        _view.collectionView.dataSource = self
    }
    
    private func setupSearchTextFieldAction() {
        self._view.searchVC.searchAndScanView.searchTextField.addTarget(self, action: #selector(textDidChange(_:)), for: .allEditingEvents)
    }
}

extension SearchResultViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultVM.searchedItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell()}
        
        if let pagination = searchResultVM.pagination {
            if countOfResults == indexPath.row + 1 && pagination.nextPage != nil {
                searchResultVM.delegate = self
                searchResultVM.getSearchedResult(query: queryForNetwork, page: pagination.nextPage ?? 1, orderBy: "popular")
            }
        }
        
        cell.delegate = self
        cell.cellModelSearched = searchResultVM.searchedItems?[indexPath.row]
        
        return cell
    }
}

extension SearchResultViewController {
    @objc func textDidChange(_ textField: FillTextField) {
        searchedQuery = textField.text ?? ""
       
        if searchedQuery != "" {
            self.perform(#selector(searchInAction), with: nil, afterDelay: 1)
        }
    }
    @objc func searchInAction(_ sender: Any) {
        if queryForNetwork == searchedQuery { return } else { queryForNetwork = searchedQuery ?? "" }
        searchResultVM.searchedItems = []
        searchResultVM.delegate = self
        searchResultVM.getSearchedResult(query: queryForNetwork, page: 1, orderBy: "popular")
    }
}

extension SearchResultViewController : SearchResultsViewModelProtocol {
    func getSearchedItems() {
        countOfResults = searchResultVM.items?.count
        _view.collectionView.reloadData()
    }
}

extension SearchResultViewController : ProductCollectionViewCellProtocol {
    func didAddToFavorites(_ cell: ProductCollectionViewCell) {
        if cell.isFavorite ?? false == false {
            cell.isFavorite = true
            addFavVM.delegate = self
            addFavVM.addToFavourite(product: cell.productId ?? 0)
        } else {
            cell.isFavorite = false
            removeFavVM.delegate = self
            removeFavVM.removeFromFavourite(product: cell.productId ?? 0)
        }
    }
    
    func didAddToCart(_ cell: ProductCollectionViewCell) {
        guard let indexPath = self._view.collectionView.indexPath(for: cell) else { return }
        
        let basket = BasketModel()
        basket.id = searchResultVM.searchedItems?[indexPath.row].id ?? 0
        basket.count = 1
        
        if let findedBasket = uiRealm.objects(BasketModel.self).filter({
            $0.id == self.searchResultVM.searchedItems?[indexPath.row].id ?? 0
        }).first {
            basket.count += findedBasket.count
            findedBasket.deleteFromRealm()
        }
        
        self.simpleTextSnackBar(title: "added_to_basket".localized(using: "Localizable"))
        basket.writeToRealm()
    }
}

extension SearchResultViewController : AddToFavouriteViewModelProtocol {
    func addToFavourite() {
        if AuthManager.shared.isAuthenticated() {
            simpleTextSnackBar(title: "added_to_favorites".localized(using: "Localizable"))
        } else {
            snackBarForLogin()
        }
      
    }
}

extension SearchResultViewController : RemoveFromFavouriteViewModelProtocol {
    func removeFromFavourite() {
        if AuthManager.shared.isAuthenticated() {
            simpleTextSnackBar(title: "remove_from_favorites".lowercased())
        } else {
            snackBarForLogin()
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductViewController()
        vc.productID = searchResultVM.searchedItems?[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchResultViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width/2.0 - 32, height: 260)
    }
}


extension SearchResultViewController {
    private func setupSearchBySpeech() {
        _view.searchVC.searchAndScanView.searchTextField.voiceButton.isEnabled = false
        
        _view.searchVC.searchAndScanView.searchTextField.voiceButtonHandler = { [weak self] in
            guard let self = self else { return }
            if self.audioEngine.isRunning {
                self.audioEngine.stop()
                self.recognitionRequest?.endAudio()
                self._view.searchVC.searchAndScanView.searchTextField.voiceButton.isEnabled = false
                self._view.searchVC.searchAndScanView.searchTextField.placeholder = "stop_record".localized(using: "Localizable")
            } else {
                do {
                    try self.startRecording()
                    self._view.searchVC.searchAndScanView.searchTextField.placeholder = "talk".localized(using: "Localizable")
                } catch {
                    self._view.searchVC.searchAndScanView.searchTextField.placeholder = "Запись недоступна"
                }
            }
        }
    }
    
    private func setupSearchRecognition() {
        speechRecognizer.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized: self._view.searchVC.searchAndScanView.searchTextField.voiceButton.isEnabled = true
                case .denied: self._view.searchVC.searchAndScanView.searchTextField.voiceButton.isEnabled = false
                case .restricted: self._view.searchVC.searchAndScanView.searchTextField.voiceButton.isEnabled = false
                case .notDetermined: self._view.searchVC.searchAndScanView.searchTextField.voiceButton.isEnabled = false
                default: self._view.searchVC.searchAndScanView.searchTextField.voiceButton.isEnabled = false
                }
            }
        }
    }
}

extension SearchResultViewController : SFSpeechRecognizerDelegate {
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            self._view.searchVC.searchAndScanView.searchTextField.voiceButton.isEnabled = true
            self._view.searchVC.searchAndScanView.searchTextField.placeholder = "talk".localized(using: "Localizable")
        } else {
            self._view.searchVC.searchAndScanView.searchTextField.voiceButton.isEnabled = false
            self._view.searchVC.searchAndScanView.searchTextField.placeholder = "Запись недоступна"
        }
    }
}

extension SearchResultViewController {
    private func startRecording() throws {
        
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                self.searchedQuery = result.bestTranscription.formattedString
                self.perform(#selector(self.searchInAction), with: nil, afterDelay: 3)
                self._view.searchVC.searchAndScanView.searchTextField.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self._view.searchVC.searchAndScanView.searchTextField.voiceButton.isEnabled = true
                self._view.searchVC.searchAndScanView.searchTextField.placeholder = "talk".localized(using: "Localizable")
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        self._view.searchVC.searchAndScanView.searchTextField.placeholder = "you_can_talk".localized(using: "Localizable")
    }
}
