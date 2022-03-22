
import UIKit

class CustomLabel: UILabel {
    
    var topInset: CGFloat = 5.0
    var bottomInset: CGFloat = 5.0
    var leftInset: CGFloat = 7.0
    var rightInset: CGFloat = 7.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    convenience init(fontSize: UIFont.AppFontSize = .l, fontWight: UIFont.GolosWeight = .regular, textColor: UIColor = .black, textAlignment: NSTextAlignment = .left, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), numberOfLines: Int = 0) {
        
        self.init()
        
        topInset = insets.top
        leftInset = insets.left
        rightInset = insets.right
        bottomInset = insets.bottom
        
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        
        font = .appFont(size: fontSize, weight: fontWight)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        self.textColor = textColor
    }
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        text = "DefaultText"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
