//  CardDetailsPresenter.swift
//  tarot

import Foundation
import UIKit

// этот протокол описывает все действия, которые могут произойти на экране
// его реализовывает флоу координатор, чтоб показать экран инфы о карточке
protocol CardDetailsPresenterOutput: AnyObject {
    
}

// этот протокол описывает события, которые происходят на экране
protocol CardDetailsPresenterProtocol {
    // экран загрузился — можно начинать что-то делать (отображать инфу)
    func viewDidLoad()
}

// отвечает за обработку событий экрана, взаимодействия с ним
// передает всё в output
final class CardDetailsPresenter {
    
    // Зависимости
    weak var view: CardDetailsViewController?
    private let cardService: CardServiceProtocol
    private weak var output: CardDetailsPresenterOutput?
    private let card: Card
    
    // MARK: - Инициализация
    
    init(
        cardService: CardServiceProtocol,
        output: CardDetailsPresenterOutput,
        card: Card
    ) {
        self.cardService = cardService
        self.output = output
        self.card = card
    }
}

// MARK: - CardDetailsPresenterProtocol

extension CardDetailsPresenter: CardDetailsPresenterProtocol {
    
    func viewDidLoad() {
        let model = CardDetailsViewModel(image: UIImage(named: card.imageName)!, description: card.description, title: card.title)
        view?.configure(with: model)
    }
}
