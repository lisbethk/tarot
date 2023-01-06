//  CardListPresenter.swift
//  tarot

import UIKit

// этот протокол описывает все действия, которые могут произойти на экране
// его реализовывает флоу координатор, чтоб показать экран инфы о карточке
protocol CardListPresenterOutput: AnyObject {
    
    // пользователь нажал карту из списка
    func didSelectCard(card: Card)
}

// этот протокол описывает события, которые происходят на экране
protocol CardListPresenterProtocol {
    
    // экран загрузился — можно начинать что-то делать (отображать инфу)
    func viewDidLoad()
    
    // пользователь выбрал карточку
    func didSelectItem(at indexPath: IndexPath)
}

// отвечает за обработку событий экрана, взаимодействия с ним
// передает всё в output
final class CardListPresenter {
    
    // Зависимости
    weak var view: CardListViewController?
    private let cardService: CardServiceProtocol
    private weak var output: CardListPresenterOutput?
    
    // MARK: - Инициализация
    
    init(cardService: CardServiceProtocol, output: CardListPresenterOutput) {
        self.cardService = cardService
        self.output = output
    }
}

// MARK: - CardListPresenterProtocol

extension CardListPresenter: CardListPresenterProtocol {
    
    func viewDidLoad() {
        
        // грузим модели карточек
        cardService.getAllCardsAndSections { info in
            
            DispatchQueue.main.async {
                
                    // модель, которую мы покажем на экране
                    var sections = [(section: CardListSection, cards: [CardListItem])]()
                    
                    for sectionWithCards in info {
                        
                        let cardModels = sectionWithCards.cards.map { card -> CardListItem in
                            let image = UIImage(named: card.imageName)
                            return CardListItem(image: image ?? UIImage())
                        }
                        
                        // записываем туда, чтоб на экране показать
                        sections.append((section: sectionWithCards.section, cards: cardModels))
                    }
                    
                    let model = CardListViewModel(sections: sections)
                    
                    // показываем на экране
                    self.view?.configure(with: model)
            }
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
        // определяем на какую карточку мы нажали
        cardService.getAllCardsAndSections { cardsAndSections in
            // показ карточки осуществляем в основном потоке
            DispatchQueue.main.async {
                let section = CardListSection.allCases[indexPath.section]
                let cards = cardsAndSections.first { $0.section == section }?.cards
                let card = cards?[indexPath.row]
                guard let card = card else { return }
                
                // передаем событие флоу координатору, чтоб он дальше что-то сделал
                self.output?.didSelectCard(card: card)
            }
        }
    }
}
