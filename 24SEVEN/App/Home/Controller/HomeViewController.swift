import UIKit

class HomeViewController: GenericViewController {
    
    let _view = HomeView()
    
    private var viewModel = HomeViewModel()
    
    var carouselVC = CarouselHomeController()
    
    var news = TopProductsViewController(type: .news)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view = _view
    }
}

extension HomeViewController {
    
    private func setup() {
        viewModel.delegate = self
        viewModel.fetchHomePage()
    }
}

extension HomeViewController: HomeViewModelProtocol {
    func didUpdateHomePage() {
        
        let compilitions = viewModel.compilitions
        let sliders = viewModel.sliders
        
        if compilitions?.count ?? 0 == 0 {
            return
        }
        
        if sliders?.count ?? 0 > 0 {
            carouselVC.images = sliders
            _view.stackView.addArrangedSubview(carouselVC.carouselView)
            addChildViewController(vc: carouselVC, embedView: false)
        }
        
        compilitions?.forEach({ (compilition) in
            
            if compilition.products?.count ?? 0 > 0 {
                let products = TopProductsViewController(type: .products)
                _view.stackView.addArrangedSubview(products._view)
                addChildViewController(vc: products, embedView: false)
                products.items = compilition
            }
        })
        
//        _view.stackView.addArrangedSubview(news._view)
//        addChildViewController(vc: news, embedView: false)
//        news._view.headerView.title = "news".localized(using: "Localizable")
//        news.posts = viewModel.postsHome
    }
}
