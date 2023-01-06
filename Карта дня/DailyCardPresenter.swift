//  CardOfTheDayPresenter.swift
//  tarot

import UIKit

protocol DailyCardPresenterOutput: AnyObject {
}

protocol DailyCardPresenterProtocol {
    func didTapDaily()
    func viewDidLoad()
}

final class DailyCardPresenter {
    
    weak var view: DailyCardViewController?
    private weak var output: DailyCardPresenterOutput?
    private var isExisted: Bool
    private let card: Card
    private let cardService: CardService
    
    // MARK: - Инициализация
    init(
        output: DailyCardPresenterOutput,
        cardService: CardService
    ) {
        self.cardService = cardService
        self.output = output
        let (card, isExisted) = cardService.getDailyCard()
        self.isExisted = isExisted
        self.card = card
    }
}
// Если карту сегодня ещё не показывали, запускаем модельку после нажатия на рубашку карты
extension DailyCardPresenter: DailyCardPresenterProtocol{
    
    func didTapDaily() {
        guard !isExisted else {
            return
        }
        
        let image = UIImage(named: card.imageName)
        let model = DailyCardViewModel(image: image!, zodiac: card.zodiac!.rawValue)
        view?.configure(with: model)
        isExisted = true
        cardService.saveCard(card: card)
    }
    
    func viewDidLoad()  {
        // Если карту сегодня уже генерировали, показываем модельку, которая уже когда-то сегодня была загружена
        if isExisted {
            let image = UIImage(named: card.imageName)
            let showed = DailyCardViewModel(image: image!, zodiac: card.zodiac!.rawValue)
            view?.configure(with: showed)
        } else {
            //        Если карту не генерировали, показываем рубашку карты и ждём нажатия
            let zodiac = String("")
            let previewImage = UIImage(named: "back")
            let previewModel = DailyCardViewModel(image: previewImage!, zodiac: zodiac)
            view?.configure(with: previewModel)
        }
    }
}

