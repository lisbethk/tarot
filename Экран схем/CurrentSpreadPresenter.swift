import UIKit

protocol CurrentSpreadPresenterOutput: AnyObject {
}

protocol CurrentSpreadPresenterProtocol {
    func viewDidLoad()
}

final class CurrentSpreadPresenter {
    
    weak var view: CurrentSpreadViewController?
    private let spreadService: SpreadServiceProtocol
    private let spreads: [Spread]
    private weak var output: CurrentSpreadPresenterOutput?
    
    
    init(
        SpreadService: SpreadServiceProtocol,
        output: CurrentSpreadPresenterOutput,
        spreads: [Spread])
    {
        self.spreadService = SpreadService
        self.output = output
        self.spreads = spreads
    }
}

extension CurrentSpreadPresenter: CurrentSpreadPresenterProtocol {
    func viewDidLoad() {
        
        var items = [SpreadListItem]()
        for spread in spreads {
            let image = UIImage(named: spread.imageName)
            let name = spread.title
            let questions = spread.description
            let item = SpreadListItem(image: image ?? UIImage(),
                                      description: questions,
                                      title: name)
            items.append(item)
        }
        
        let model = CurrentSpreadViewModel(items: items)
        
        // показываем на экране
        self.view?.configure(with: model)
        
    }
}
