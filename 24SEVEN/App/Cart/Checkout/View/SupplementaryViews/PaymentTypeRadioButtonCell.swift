
import UIKit

class PaymentTypeRadioButtonCell: UITableViewCell {
    
    private let selectedColor = UIColor.defaultOrange
    private let deselectedColor = UIColor.defaultOrange
    
    var radioButton: CustomRadioButton = {
        let radio = CustomRadioButton()
        radio.translatesAutoresizingMaskIntoConstraints = false
        return radio
    }()
    
    let radioText = CustomLabel(fontSize: .l, fontWight: .regular,  textColor: .mainTextColor ?? UIColor.black, textAlignment: .left, numberOfLines: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        self.layout()
    }
  
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func update(with color: UIColor) {
        backgroundColor = color
        radioButton.selectedColor = color == .darkGray ? .white : selectedColor
        radioButton.deselectedColor = color == .darkGray ? .lightGray : deselectedColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            return radioButton.select(animated: animated)
        }
        radioButton.deselect(animated: animated)
    }
    
    private func layout() {
        
        self.contentView.addSubview(radioButton)
        self.contentView.addSubview(radioText)
        
        NSLayoutConstraint.activate([
            radioButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            radioButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            radioButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            radioButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            radioButton.heightAnchor.constraint(equalToConstant: 20),
            radioButton.widthAnchor.constraint(equalToConstant: 20),
            
            radioText.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 16),
            radioText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            radioText.centerYAnchor.constraint(equalTo: radioButton.centerYAnchor),
        ])
    }
}
