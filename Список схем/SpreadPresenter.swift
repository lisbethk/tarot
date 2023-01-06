import UIKit

protocol SpreadPresenterOutput: AnyObject {
    func didSelectCategory(spread: [Spread])
}

protocol SpreadPresenterProtocol {
    func didTapCategory(at indexPath: IndexPath)
    func viewDidLoad()
}

final class SpreadPresenter {
    
    weak var view: SpreadViewController?
    private let spreadService: SpreadServiceProtocol
    private weak var output: SpreadPresenterOutput?
    
    init(SpreadService: SpreadServiceProtocol, output: SpreadPresenterOutput) {
        self.spreadService = SpreadService
        self.output = output
    }
}

extension SpreadPresenter: SpreadPresenterProtocol{
    func viewDidLoad() {
    }
    
    func didTapCategory(at indexPath: IndexPath) {
        spreadService.getAllSpreadsAndSections { result in
            // показ карточки осуществляем в основном потоке
            DispatchQueue.main.async {
                guard case let .success(spreadsAndSections) = result else {
                    return
                }
                
                let section = SpreadSection.allCases[indexPath.row]
                let allSpreads = spreadsAndSections.first { $0.section == section }?.spreads
                guard let spreads = allSpreads else { return }
                // передаем событие флоу координатору, чтоб он дальше что-то сделал
                self.output?.didSelectCategory(spread: spreads)
                
            }
        }
    }
}
