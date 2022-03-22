
import UIKit

public enum Duration {
    case short, long, indefinite
    
    var interval: TimeInterval {
        switch self {
        case .short: return 0.6
        case .long: return 1.8
        case .indefinite: return .infinity
        }
    }
}
