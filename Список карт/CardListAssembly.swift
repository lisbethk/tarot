//  CardListAssembly.swift
//  tarot

import Foundation
import UIKit

// эта штука создает остальные части экрана списка карт
// и засовывает их друг в друга
// она должна вернуть UIViewController (сам экран списка карт),
// для дальнейшего показа во флоу координаторе
final class CardListAssembly {
    
    // тут мы создаем сервис, который пригодится в презентере,
    // чтоб получить список всех карт
    private lazy var cardService = CardService()
    
    // этот метод собственно собирает весь экран
    // он принимает на вход flowCoordinator, которому презентер скажет,
    // когда что-то произошло и что-то нужно показать
    func assemble(output: CardListPresenterOutput) -> UIViewController {
        let presenter = CardListPresenter(cardService: cardService, output: output)
        let viewController = CardListViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
