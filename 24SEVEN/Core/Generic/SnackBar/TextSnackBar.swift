import UIKit

final class TextSnackBar: IBView {
    
    public static let shared = TextSnackBar()
    private var containerBottomAnchor: NSLayoutConstraint!
    var heightConstant: CGFloat = 50
    
    lazy var containerView = IBView()
    lazy var infoLabel = CustomLabel(fontSize: .l, fontWight: .regular, textColor: .white, textAlignment: .left, numberOfLines: 2)
    
    override init() {
        super.init()
        self.backgroundColor = .clear
        self.isHidden = true
        
        setupConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setupConstraints() {
        self.containerBottomAnchor = self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 100)
        guard let currentWindow = UIApplication.shared.keyWindow else { return }
        let bottomPadding = currentWindow.safeAreaInsets.bottom
        heightConstant += bottomPadding
        
        currentWindow.addSubview(self)
        addSubview(containerView)
        containerView.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: currentWindow.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: currentWindow.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: currentWindow.bottomAnchor),
            self.heightAnchor.constraint(equalToConstant: heightConstant),
            
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.containerView.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.containerBottomAnchor,
            
            self.infoLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
            self.infoLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.infoLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16),
        ])
    }

    public func show(backgroundColor: UIColor = UIColor.tabBarPrimaryColor ?? UIColor.black, title: String, titleColor: UIColor = .white, duration: Duration = .short) {
       
        self.isHidden = false
        self.containerView.backgroundColor = backgroundColor
        self.infoLabel.text = title
        self.infoLabel.textColor = titleColor
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.containerBottomAnchor.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: {
                self?.layoutIfNeeded()
            }, completion: { _ in
                guard duration != .indefinite else { return }
                self?.hide(duration)
            })
        }
    }
    
    private func hide(_ duration: Duration) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration.interval) { [weak self] in
            self?.containerBottomAnchor.constant = 100
            UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
                self?.layoutIfNeeded()
            }, completion: { _ in
                self?.isHidden = true
            })
        }
    }
}
