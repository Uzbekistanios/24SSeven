
import UIKit

public class CustomRadioButton: UIView {
    
    private let waveCircle = UIView()
    private let circle = UIView()
    private let innerCircle = UIView()
    
    @IBInspectable
    public var selectedColor = UIColor.defaultOrange {
        willSet {
            innerCircle.layer.borderColor = newValue.cgColor
            waveCircle.layer.borderColor  = newValue.cgColor
        }
    }
    
    @IBInspectable
    public var deselectedColor = UIColor.defaultOrange {
        willSet {
            circle.layer.borderColor = newValue.cgColor
        }
    }
    
    public private(set) var isSelected = false
    
    public var useTapGestureRecognizer = true {
        willSet {
            guard newValue else { return removeGestureRecognizer(tapGesture) }
            addTapGesture()
        }
    }
    
    private var innerBorderWidth: CGFloat {
        return innerCircle.frame.width * 0.6
    }
    
    private let innerIncreaseDelta: CGFloat = 1.1
    
    private var innerIncreasedWidth: CGFloat {
        return innerCircle.frame.width * innerIncreaseDelta
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let tg = UITapGestureRecognizer()
        tg.numberOfTapsRequired = 1
        tg.numberOfTouchesRequired = 1
        tg.addTarget(self, action: #selector(self.toggleState))
        return tg
    }()
    
    private var didSelect: () -> Void = { } {
        willSet {
            addTapGesture()
        }
    }
    
    private var didDeselect: () -> Void = { } {
        willSet {
            addTapGesture()
        }
    }
    
    public func onSelect(execute closure: @escaping () -> Void) {
        didSelect = closure
    }
    
    public func onDeselect(execute closure: @escaping () -> Void) {
        didDeselect = closure
    }
    
    private func innerBorderIncrease() -> CABasicAnimation {
        let borderWidth = CABasicAnimation(keyPath: "borderWidth")
        borderWidth.duration       = 0.2
        borderWidth.fromValue      = 0.0
        borderWidth.toValue        = innerBorderWidth
        borderWidth.timingFunction = CAMediaTimingFunction(name: .easeIn)
        borderWidth.fillMode       = .backwards
        borderWidth.beginTime      = layer.lth_currentMediaTime
        return borderWidth
    }
    
    private func innerIncreaseGroup() -> CAAnimationGroup {
        let group = CAAnimationGroup()
        
        let bounds       = CABasicAnimation(keyPath: "bounds")
        bounds.fromValue = NSValue(cgRect: innerCircle.frame)
        bounds.toValue   = NSValue(cgRect: CGRect(x: 0, y: 0, width: innerIncreasedWidth, height: innerIncreasedWidth))
        
        let cornerRadius       = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadius.fromValue = innerCircle.layer.cornerRadius
        cornerRadius.toValue   = innerCircle.layer.cornerRadius * innerIncreaseDelta
        
        group.duration       = 0.1
        group.animations     = [bounds, cornerRadius]
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        group.beginTime      = layer.lth_currentMediaTime + 0.23
        
        return group
    }
    
    private func innerDecreaseGroup() -> CAAnimationGroup {
        let group = CAAnimationGroup()
        
        let bounds = CABasicAnimation(keyPath: "bounds")
        bounds.toValue   = NSValue(cgRect: innerCircle.frame)
        bounds.fromValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: innerIncreasedWidth, height: innerIncreasedWidth))
        
        let cornerRadius       = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadius.fromValue = innerCircle.layer.cornerRadius * innerIncreaseDelta
        cornerRadius.toValue   = innerCircle.layer.cornerRadius
        
        group.duration       = 0.15
        group.animations     = [bounds, cornerRadius]
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        group.beginTime      = layer.lth_currentMediaTime + 0.31
        
        return group
    }
    
    private func circleBorderColor() -> CABasicAnimation {
        let borderColor = CABasicAnimation(keyPath: "borderColor")
        
        borderColor.duration       = 0.15
        borderColor.fromValue      = deselectedColor.cgColor
        borderColor.toValue        = selectedColor.cgColor
        borderColor.timingFunction = CAMediaTimingFunction(name: .linear)
        borderColor.fillMode       = .backwards
        borderColor.beginTime      = layer.lth_currentMediaTime + 0.28
        
        return borderColor
    }
    
    private func waveIncreaseGroup() -> CAAnimationGroup {
        let start = 0.21
        let delta = CGFloat(2.15)
        let width = waveCircle.frame.width * delta
        let group = CAAnimationGroup()
        
        let bounds       = CABasicAnimation(keyPath: "bounds")
        bounds.fromValue = NSValue(cgRect: waveCircle.frame)
        bounds.toValue   = NSValue(cgRect: CGRect(x: 0, y: 0, width: width, height: width))
        
        let cornerRadius       = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadius.fromValue = waveCircle.layer.cornerRadius
        cornerRadius.toValue   = waveCircle.layer.cornerRadius * delta
        
        group.duration       = 0.25
        group.animations     = [bounds, cornerRadius]
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        group.beginTime      = layer.lth_currentMediaTime + start
        
        return group
    }
    
    private func waveAlphaDecrease() -> CABasicAnimation {
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.duration       = 0.31
        opacity.fromValue      = 0.3
        opacity.toValue        = 0
        opacity.timingFunction = CAMediaTimingFunction(name: .easeOut)
        opacity.beginTime      = layer.lth_currentMediaTime + 0.26
        return opacity
    }
    
    private func waveBorderDecrease() -> CABasicAnimation {
        let borderWidth = CABasicAnimation(keyPath: "borderWidth")
        borderWidth.duration       = 0.26
        borderWidth.fromValue      = frame.width * 0.3
        borderWidth.toValue        = 0
        borderWidth.timingFunction = CAMediaTimingFunction(name: .easeOut)
        borderWidth.beginTime      = layer.lth_currentMediaTime + 0.29
        return borderWidth
    }
    
    private func innerDecreaseGroupReverse(duration: Double) -> CAAnimationGroup {
        let group = CAAnimationGroup()
        
        let borderWidth       = CABasicAnimation(keyPath: "borderWidth")
        borderWidth.fromValue = innerBorderWidth
        borderWidth.toValue   = 0.0
        
        let opacity       = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 1.0
        opacity.toValue   = 0.0
        
        group.duration       = duration
        group.animations     = [borderWidth, opacity]
        group.timingFunction = CAMediaTimingFunction(name: .easeIn)
        group.beginTime      = layer.lth_currentMediaTime
        
        return group
    }
    
    private func circleBorderColorReverse(duration: Double) -> CABasicAnimation {
        let borderColor = CABasicAnimation(keyPath: "borderColor")
        borderColor.duration       = duration
        borderColor.fromValue      = selectedColor.cgColor
        borderColor.toValue        = deselectedColor.cgColor
        borderColor.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        borderColor.beginTime      = layer.lth_currentMediaTime
        return borderColor
    }
    
    @objc(selectAnimated:)
    public func select(animated: Bool = true) {
        guard !isSelected else { return }
        isSelected = true
        innerCircle.layer.borderWidth = innerBorderWidth
        circle.layer.borderColor      = selectedColor.cgColor
        didSelect()
        
        guard animated else { return }
        
        innerCircle.layer.add(innerBorderIncrease(), forKey: "innerBorderWidth")
        innerCircle.layer.add(innerIncreaseGroup(), forKey: "innerIncreaseGroup")
        innerCircle.layer.add(innerDecreaseGroup(), forKey: "innerDecreaseGroup")
        
        circle.layer.add(circleBorderColor(), forKey: "circleBorderColor")
        
        waveCircle.layer.add(waveIncreaseGroup(), forKey: "innerDecreaseGroup")
        waveCircle.layer.add(waveAlphaDecrease(), forKey: "outerAlphaDecrease")
        waveCircle.layer.add(waveBorderDecrease(), forKey: "outerBorderDecrease")
    }
    
    @objc(deselectAnimated:)
    public func deselect(animated: Bool = true) {
        guard isSelected else { return }
        isSelected = false
        removeAnimations()
        setDeselectedEndValues()
        didDeselect()
        
        guard animated else { return }
        
        let duration = 0.2
        innerCircle.layer.add(innerDecreaseGroupReverse(duration: duration), forKey: "innerDecreaseGroupReverse")
        circle.layer.add(circleBorderColorReverse(duration: duration), forKey: "circleBorderColorReverse")
    }
    
    private func setDeselectedEndValues() {
        innerCircle.layer.borderWidth = 0
        circle.layer.borderColor      = deselectedColor.cgColor
    }
    
    private func removeAnimations() {
        waveCircle.layer.removeAllAnimations()
        circle.layer.removeAllAnimations()
        innerCircle.layer.removeAllAnimations()
    }
    
    @objc private func toggleState() {
        guard isSelected else { return select() }
        deselect()
    }
    
    private func addTapGesture() {
        guard useTapGestureRecognizer else { return }
        guard gestureRecognizers?.contains(tapGesture) != true else { return }
        addGestureRecognizer(tapGesture)
    }
    
    public init(diameter: CGFloat = 18, selectedColor: UIColor? = nil, deselectedColor: UIColor? = nil) {
        let size = CGSize(width: diameter, height: diameter)
        super.init(frame: CGRect(origin: .zero, size: size))
        commonInit(diameter: diameter, selectedColor: selectedColor, deselectedColor: deselectedColor)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit(diameter: frame.size.width, selectedColor: nil, deselectedColor: nil)
    }
    
    private func commonInit(diameter: CGFloat, selectedColor: UIColor?, deselectedColor: UIColor?) {
        let innerCircleDiameter = diameter / 1.6
        let radius = diameter * 0.5
        let center = CGPoint(x: radius, y: radius)
        
        backgroundColor      = .clear
        self.selectedColor   = selectedColor ?? self.selectedColor
        self.deselectedColor = deselectedColor ?? self.deselectedColor
        
        addSubview(circle)
        circle.backgroundColor    = .clear
        circle.layer.cornerRadius = radius
        circle.layer.borderColor  = self.deselectedColor.cgColor
        circle.layer.borderWidth  = diameter * 0.1
        circle.frame.size         = CGSize(width: diameter, height: diameter)
        circle.center             = center
        
        addSubview(innerCircle)
        innerCircle.backgroundColor    = .clear
        innerCircle.layer.cornerRadius = innerCircleDiameter * 0.5
        innerCircle.layer.borderColor  = self.selectedColor.cgColor
        innerCircle.layer.borderWidth  = 0
        innerCircle.frame.size         = CGSize(width: innerCircleDiameter, height: innerCircleDiameter)
        innerCircle.center             = center
        
        addSubview(waveCircle)
        waveCircle.backgroundColor    = .clear
        waveCircle.layer.cornerRadius = innerCircle.layer.cornerRadius
        waveCircle.layer.borderColor  = self.selectedColor.cgColor
        waveCircle.layer.borderWidth  = 0
        waveCircle.alpha              = 0
        waveCircle.frame.size         = innerCircle.frame.size
        waveCircle.center             = center
    }
}

fileprivate extension CALayer {
    var lth_currentMediaTime: CFTimeInterval {
        return convertTime(CACurrentMediaTime(), from: nil)
    }
}
