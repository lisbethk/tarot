import UIKit

final class SpreadViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource {
        
    let tableView = UITableView()
    let data = ["Общие", "На ситуацию", "На отношения", "На карьеру", "Характеристика личности"]
    
    private let presenter: SpreadPresenterProtocol
    
    // MARK: - Init
    
    init(presenter: SpreadPresenterProtocol) {
        self.presenter = presenter
        
        // вызываем инициализатор родительского класса UIViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath as IndexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.font = .yarin(ofSize: 25)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        presenter.didTapCategory(at: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        title = "Категории"
    }
}
