
import UIKit

class CustomTextView: UITextView {

    init(inset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), withPlaceHolder: Bool = false, textString : String = "") {
        super.init(frame: .zero, textContainer: nil)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentInset = inset
        layer.cornerRadius = 10
     
        font = .appFont(size: .l, weight: .regular)
        
        if withPlaceHolder {
            text = textString
            textColor = UIColor.lightGray
        }
    
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
