
import UIKit

class FeedBackAddCommentView : GenericScrollView {
    
    let pan = PanView()
    
    let title = UILabel.makeLabel(string: "pls_your_comments".localized(using: "Localizable"), size: .l, weight: .semibold, alignment: .center)
    
    let textView = CustomTextView(withPlaceHolder: true, textString: "your_comments".localized(using: "Localizable"))
    
    let targetView = TargetButtonView(title: "leave_comment".localized(using: "Localizable"))
    
    override init() {
        super.init()
        
        scrollView.alwaysBounceVertical = false
        removeNavBar()
        style()
        layout()
    }
 
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        backgroundColor = UIColor.mainBackgroundColor
        pan.title = "leave_feedback".localized(using: "Localizable")
        textView.layer.cornerRadius = 8
    }
    
    private func layout() {
        scrollContent.addSubview(pan)
        scrollContent.addSubview(title)
        scrollContent.addSubview(textView)
        scrollContent.addSubview(targetView)
        
        NSLayoutConstraint.activate([
            pan.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            pan.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 12),
            pan.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16),

            title.topAnchor.constraint(equalTo: pan.bottomAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16),
            
            textView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),

            targetView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 56),
            targetView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            targetView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            targetView.bottomAnchor.constraint(equalTo: scrollContent.bottomAnchor, constant: -10)
        ])
    }
}
