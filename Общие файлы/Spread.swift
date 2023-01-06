import Foundation

enum SpreadSection:
    String,
    Encodable,
    CaseIterable,
    Decodable {
    
    case basic
    case situation
    case relationship
    case career
    case personality
    
    var title: String {
        switch self {
        case .basic:
            return "Общие"
        case .situation:
            return "На ситуацию"
        case .relationship:
            return "На отношения"
        case .career:
            return "На карьеру"
        case .personality:
            return "Характеристика личности"
        }
    }
}

struct Spread: Codable {
    let section: SpreadSection
    let title: String
    let imageName: String
    let description: String
    
}
