

import UIKit

protocol FeedBackAddCommentDelegate {
    func didSelectFeedBack(option: String)
}

class FeedBackAddCommentController : GenericViewController{
 
    let _view = FeedBackAddCommentView()
    
    var delegate: FeedBackAddCommentDelegate?
    
    override func loadView() {
        view = _view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _view.textView.delegate = self
        targetAction()
    }
}

extension FeedBackAddCommentController {
    private func targetAction() {
        _view.targetView.targetClosure = { [weak self] in
            guard let self = self else { return }
            self.delegate?.didSelectFeedBack(option: self._view.textView.text)
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension FeedBackAddCommentController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "your_comments".localized(using: "Localizable")
            textView.textColor = UIColor.lightGray
        }
    }
}
