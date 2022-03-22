//
//  NewsViewController.swift
//  24SEVEN
//
//  Created by Islom on 20/02/21.
//

import UIKit

class NewsViewController : GenericViewController {
    
    let _view = NewsView()
    
    var newsId: Int?
    
    let viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.fetchMainNewsItem(productId: newsId ?? 1)
       
        setupButton()
    }
    
    override func loadView() {
        view = _view
    }
}

extension NewsViewController {
    private func setupButton() {
        
        var arrayOfItems: [Any]?
        
        _view.share.shareViewHandler = { [weak self] in
            if self?.viewModel.newsItem?.image?.count != 0 {
                downloadImage(with : self?.viewModel.newsItem?.image ?? "") { image in
                    guard let image  = image else { return}
                    arrayOfItems = ["\(self?.viewModel.newsItem?.url ?? "")", image]
                }
            } else {
                arrayOfItems = ["\(self?.viewModel.newsItem?.url ?? "")", UIImage(named: "LargeLogo") as Any]
            }
           
            let activityViewController = UIActivityViewController(activityItems: arrayOfItems ?? [], applicationActivities: nil)
                    activityViewController.excludedActivityTypes = [
                        UIActivity.ActivityType.postToFacebook,
                        UIActivity.ActivityType.postToTwitter,
                        UIActivity.ActivityType.postToWeibo,
                        UIActivity.ActivityType.postToFlickr,
                        UIActivity.ActivityType.mail,
                        UIActivity.ActivityType.message,
                        UIActivity.ActivityType.postToTencentWeibo
                    ]
            
            activityViewController.completionWithItemsHandler = { _, bool, _, _ in
                if bool {
                    self?.simpleTextSnackBar(title: "sent_success".localized(using: "Localizable"))
                }
            }
            
            activityViewController.popoverPresentationController?.sourceView = self?.view
            self?.present(activityViewController, animated: true, completion: nil)
        }
    }
}

extension NewsViewController : NewsViewModelProtocol {
    func didUpdateNewsItem() {
        _view.viewModel = viewModel
    }
}
