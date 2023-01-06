//
//  Card.swift
//  tarot


import Foundation

enum CardListSection: String, Codable, CaseIterable {
    case major
    case wands
    case cups
    case swords
    case pentacles
    
    var title: String {
        switch self {
        case .major:
            return "THE MAJOR"
        case .wands:
            return "SUIT OF WANDS"
        case .cups:
            return "SUIT OF CUPS"
        case .swords:
            return "SUIT OF SWORDS"
        case .pentacles:
            return "SUIT OF PENTACKLES"
        }
    }
}

struct Card: Codable {
    let section: CardListSection
    let title: String
    let imageName: String
    let description: String
    let zodiac: Zodiac?
}

enum Zodiac: String, Codable {
    case aries = "Овен"
    case taurus = "Телец"
    case gemini = "Близнецы"
    case cancer = "Рак"
    case leo = "Лев"
    case virgo = "Дева"
    case libra = "Весы"
    case scorpius = "Скорпион"
    case sagittarius = "Стрелец"
    case capricornus = "Козерог"
    case aquarius = "Водолей"
    case pisces = "Рыбы"
}
