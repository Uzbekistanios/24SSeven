
import UIKit

final class ContentSizedTableView: UITableView {
    
    var maxHeight: CGFloat = 350
    var minHeight: CGFloat = 0
    var tableViewHeightAnchor: NSLayoutConstraint!
    
    override var contentSize: CGSize {
        didSet {
            
            if tableViewHeightAnchor != nil {
                tableViewHeightAnchor.isActive = false
            }
            
            tableViewHeightAnchor = heightAnchor.constraint(equalToConstant: min(maxHeight, max(minHeight, contentSize.height)))
            
            tableViewHeightAnchor.priority = .required

            tableViewHeightAnchor.isActive = true
            
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
