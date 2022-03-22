
import Foundation
import Localize_Swift

enum Language : String {
    case Russian = "ru"
    case Uzbek = "uz"
}

class LanguageManager {
    static let shared = LanguageManager()
    
    init() {
        if self.language == nil {
            self.language = iOSCurrentLanguage
        } else {
            self.updateLanguage(language: self.language)
        }
    }
    
    var language : Language! {
        get {
            if let rawValue = UserPreferences.shared.currentLanguage {
                if rawValue == "Uzbek" {
                    return Language(rawValue: "uz")!
                } else {
                    return Language(rawValue: "ru")!
                }
            } else {
                return nil
            }
        } set (value) {
            UserDefaults.standard.set(value.rawValue, forKey: "CURRENT_LANGUAGE")
            UserDefaults.standard.synchronize()
            self.updateLanguage(language: value)
        }
    }
    
    func updateLanguage(language:Language) {
        switch language {
        case Language.Uzbek:
            Localize.setCurrentLanguage("uz")
            break
        case Language.Russian:
            Localize.setCurrentLanguage("ru")
            break
        }
    }
    
    private var iOSCurrentLanguage:Language {
        if Locale.current.languageCode == "uz" {
            return Language.Uzbek
        } else {
            return Language.Russian
        }
    }
    
}
