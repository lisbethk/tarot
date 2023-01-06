//
//  CardOfTheDayAssembly.swift
//  tarot
//
//
import Foundation
import UIKit

final class DailyCardAssembly {
    
    private lazy var cardService = CardService()
    // сборка экрана
    func assemble(output: DailyCardPresenterOutput) -> UIViewController {
        let presenter = DailyCardPresenter(output: output, cardService: cardService)
        let viewController = DailyCardViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}

