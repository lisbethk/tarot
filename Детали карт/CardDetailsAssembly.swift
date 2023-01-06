//  CardDetailsAssembly.swift
//  tarot

import Foundation
import UIKit

final class CardDetailsAssembly {
    
    private lazy var cardService = CardService()
    
    func assemble(output: CardDetailsPresenterOutput, card: Card) -> UIViewController {
        let presenter = CardDetailsPresenter(cardService: cardService, output: output, card: card)
        let viewController = CardDetailsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
