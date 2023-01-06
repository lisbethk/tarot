import UIKit

final class CurrentSpreadAssembly {
    
    private lazy var spreadService = SpreadService()
    
    // сборка экрана
    func assemble(output: CurrentSpreadPresenterOutput, spread: [Spread]) -> UIViewController {
        let presenter = CurrentSpreadPresenter(SpreadService: spreadService,
                                               output: output,
                                               spreads: spread)
        let viewController = CurrentSpreadViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
