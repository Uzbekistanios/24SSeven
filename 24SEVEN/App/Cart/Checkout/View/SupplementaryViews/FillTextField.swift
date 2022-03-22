
import UIKit

enum TextFieldType: Int {
    
    case string
    case number
    case smsCode
    case email
    case phone
    case date
    case other
    
    var keyboard: UIKeyboardType {
        switch self {
        
        case .string:
        return .default
        
        case .number, .date, .smsCode:
        return .numberPad
            
        case .phone:
        return .phonePad
            
        case .email:
        return .emailAddress
            
        default:
            return .alphabet
        }
    }
}


class FillTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 5)
    
    var type: TextFieldType = .string {
        didSet {
            keyboardType = type.keyboard
            tag = type.rawValue
        }
    }
    
    init(placeholder: String, type: TextFieldType = .string) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.appFont(size: .m, weight: .medium)
        ]
        let attributedStr = NSAttributedString(string: placeholder, attributes: attrs)
        attributedPlaceholder = attributedStr
        backgroundColor = UIColor.mainSubviewColor
        layer.cornerRadius = 8.0
        isUserInteractionEnabled = true
        isEnabled = true
        font = UIFont.appFont(size: .m, weight: .medium)
        keyboardType = type.keyboard
        tag = type.rawValue
        self.type = type
        
        self.addTarget(self, action: #selector(textDidChange(_:)), for: .allEditingEvents)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension FillTextField {
    @objc func textDidChange(_ textField: FillTextField) {
        switch textField.type {
        case .phone:
            textField.text = textField.text?.phoneFormat(with: "+XXX XX XXX XX XX")
        case .date:
            textField.text = textField.text?.phoneFormat(with: "XX/XX/XXXX")
        case .smsCode:
            textField.text = textField.text?.phoneFormat(with: "XXXXXX")
        default:
            break
        }
    }
}

