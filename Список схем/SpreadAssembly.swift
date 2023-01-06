import UIKit

final class SpreadAssembly {
    private lazy var spreadService = SpreadService()
    
    // сборка экрана
    func assemble(output: SpreadPresenterOutput) -> UIViewController {
        let presenter = SpreadPresenter(SpreadService: spreadService,
                                        output: output)
        let viewController = SpreadViewController(presenter: presenter)
        presenter.view = viewController
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.yarin(ofSize: 40)]
        return navigationController
    }
}
