//  CardService.swift
//  tarot

import Foundation
import SwiftUI

protocol CardServiceProtocol {
    
    // получить список карт и секций
    func getAllCardsAndSections(completion: @escaping ([(section: CardListSection, cards: [Card])]) -> Void)

}

// отвечает за получение всякой инфы о картах
final class CardService: CardServiceProtocol {
   
    private var allCardsAndSections: [(section: CardListSection, cards: [Card])]?
    
    func getAllCardsAndSections(completion: @escaping ([(section: CardListSection, cards: [Card])]) -> Void) {
        
        //  MARK: перенос задачи на другой поток
        
        DispatchQueue.global(qos: .background).async {
        completion(self.getAllCardsAndSections())
            
        }
    }
    
    // MARK: распределяем карты по секциям
    func getAllCardsAndSections() -> [(section: CardListSection, cards: [Card])] {
        
        if let uploadedCards = allCardsAndSections {
            return uploadedCards
        }
        var result = [(CardListSection, [Card])]()
        let cards = parseJSON() ?? []
        for section in CardListSection.allCases {
            let cards = cards.filter { $0.section == section }
            result.append((section, cards))
        }
        allCardsAndSections = result
        return result
    }
    
    private func readFile() -> Data? {
        
        do {
            if let bundlePath = Bundle.main.path(forResource: "card descriptions", ofType: "json"),
               let cardDescriptionsData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return cardDescriptionsData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func parseJSON() -> [Card]? {

        
        do {
            guard let data = readFile() else {
                return nil
            }
            let decodedData = try JSONDecoder().decode([Card].self, from: data)
            return decodedData
        } catch {
            print(error)
        }
        return nil
    }
    
    // MARK: получаем из массива карту дня
    func getDailyCard() -> (Card, isExisted: Bool) {
        
        let allCards = parseJSON() ?? []
        // карта должна показываться одна и та же в течении дня
        if
            let imageName = UserDefaults.standard.object(forKey: "CardName") as? String,
            let date = UserDefaults.standard.object(forKey: "Date") as? Date,
            Calendar.current.isDateInToday(date),
            let card = allCards.first(where: { $0.imageName == imageName })
                
        {
            return (card, true)
        }
        // поиск карт со значением зодиака
        var zodiacCards = [Card]()
        for card in allCards {
            guard card.zodiac != nil else { continue }
            zodiacCards.append(card)
        }
        
        guard let card = zodiacCards.randomElement() else {
            fatalError()
        }
        
        return (card, false)
    }
    
    func saveCard(card: Card) {
        UserDefaults.standard.set(card.imageName, forKey: "CardName")
        UserDefaults.standard.set(Date(), forKey: "Date")
    }
}
