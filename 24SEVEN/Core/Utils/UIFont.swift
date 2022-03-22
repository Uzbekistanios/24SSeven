
import UIKit


fileprivate let fonts: [String] = [
    "Golos_Text_Bold",
    "Golos_Text_Regular",
    "Golos_Text_Demibold",
    "Golos_Text_Medium",
    "Golos_Text_Black",
]

public extension UIFont {
    
    enum AppFontSize: CGFloat {
        case s = 9
        case m = 14
        case l = 17
        case xl = 21
        case xxl = 24
        case pageTitle = 29
        case ultraPageTitle = 34
        
        func getSizeForDevice() -> CGFloat {
            return self.rawValue * 1.2
        }
    }
    
    enum GolosWeight: String {
        case semibold = "GolosText-DemiBold"
       
        case bold = "GolosText-Bold"
        
        case regular = "GolosText-Regular"
        
        case medium = "GolosText-Medium"
        
        case black = "GolosText-Black"
    }
    
    static func appFont(size: AppFontSize = .l, weight: GolosWeight) -> UIFont {
        guard let font = UIFont(name: weight.rawValue, size: size.rawValue) else {
            return UIFont.systemFont(ofSize: size.rawValue)
        }
        return font
    }
  
    @nonobjc class func loadAllFonts() {
        let bundleIdentifier = "com.babaevislom.-4SEVEN"

        fonts.forEach { (name) in
            registerFontWithFilenameString(name, bundleIdentifierString: bundleIdentifier)
        }
    }

    private static func registerFontWithFilenameString(_ filenameString: String, bundleIdentifierString: String) {
        guard let frameworkBundle = Bundle(identifier: bundleIdentifierString) else { return }

        if frameworkBundle.isLoaded {
            frameworkBundle.load()
        }

        guard let pathForResourceString = frameworkBundle.path(forResource: filenameString, ofType: "ttf") else { return }
        guard let fontData = NSData(contentsOfFile: pathForResourceString) else { return }
        guard let dataProvider = CGDataProvider(data: fontData) else { return }
        guard let fontRef = CGFont(dataProvider) else { return }
        var errorRef: Unmanaged<CFError>? = nil

        if (CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false) {
            NSLog("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }
}
   

