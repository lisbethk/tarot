//  MainFlowCoordinator.swift
//  tarot

import UIKit

// штука, которая отвечает за переходы между экранами
final class MainFlowCoordinator: CardDetailsPresenterOutput {
    
    // lazy — не нужна нам сразу же, может создасться потом (при обращении к ней)
    private lazy var cardListAssembly = CardListAssembly()
    private lazy var cardDetailsAssembly = CardDetailsAssembly()
    private lazy var dailyCardAssembly = DailyCardAssembly()
    
    // вью контроллер, который лежит в корне экранов
    private var rootViewController = UITabBarController()
    
    // начинает показ наших экранов в окне window
    func start(from window: UIWindow) {
        
        let listViewController = cardListAssembly.assemble(output: self)
        listViewController.tabBarItem = .init(title: "CARDS",image: UIImage(named: "cards"), selectedImage: nil)
        let dailyCardViewController = dailyCardAssembly.assemble(output: self)
        dailyCardViewController.tabBarItem = .init(title: "DAILY", image: UIImage(named: "daily"), selectedImage: nil)
        let spreadViewController = SpreadViewController()
        spreadViewController.tabBarItem = .init(title: "SPREAD", image: UIImage(named: "spread"), selectedImage: nil)
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        rootViewController.setViewControllers([listViewController,spreadViewController, dailyCardViewController], animated: true)
    }
}

// действия, которые происходят на экране списка карт
extension MainFlowCoordinator: CardListPresenterOutput {
    
    // выбрали карточку — нужно показать экран деталей карты
    func didSelectCard(card: Card) {
        let detailsViewController = cardDetailsAssembly.assemble(output: self, card: card)
        if let sheet = detailsViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        rootViewController.present(detailsViewController, animated: true)
    }
}

// действия, которые происходят на экране карты дня
extension MainFlowCoordinator: DailyCardPresenterOutput {}
