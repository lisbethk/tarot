import UIKit

struct CardDetailsItem {
    let image: UIImage
}

struct CardDetailsViewModel {
    var image: UIImage
    var description: String
    var title: String
}

// протокол для взаимодействия с экраном деталей карт
protocol CardDetailsViewControllerProtocol {
    
    // сконфигурировать (показать контент) экран моделькой
    func configure(with model: CardDetailsViewModel)
}

// экран деталей карт
final class CardDetailsViewController: UIViewController, CardDetailsViewControllerProtocol {
    
    
    // MARK: - Переменные
    
    private let presenter: CardDetailsPresenterProtocol
    
    // MARK: - Init
    
    init(presenter: CardDetailsPresenterProtocol) {
        self.presenter = presenter
        
        // вызываем инициализатор родительского класса UIViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Конфигурация вьюхи
    
    func configure(with model: CardDetailsViewModel) {
        imageView.image = model.image
        cardDescription.text = model.description
        cardTitle.text = model.title
    }
    
    // MARK: - переменные отображающиеся на экране деталей
    
    private lazy var imageView = UIImageView()
    private lazy var cardDescription = UILabel()
    private lazy var cardTitle = UILabel()
    private lazy var scrollView = UIScrollView()
    private lazy var stackView = UIStackView()
    
    // MARK: - layout деталей карт
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(cardTitle)
        stackView.addArrangedSubview(cardDescription)
        stackView.axis = .vertical

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.showsVerticalScrollIndicator = false
        
        cardDescription.font = UIFont(name: "Yarin", size: 23)
        cardDescription.adjustsFontSizeToFitWidth = true
        cardDescription.lineBreakMode = .byWordWrapping
        cardDescription.numberOfLines = 0
        
        cardTitle.font = UIFont(name: "Yarin", size: 33)
        cardTitle.textAlignment = .center
        
        view.addSubview(imageView)
        view.backgroundColor = .systemBackground
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(stackView).offset(20)
            make.height.equalTo(210)
            make.width.equalTo(120)
            make.centerX.equalTo(stackView)
            
        }
        cardDescription.snp.makeConstraints { make in
            make.top.equalTo(cardTitle).offset(60)
            make.trailing.equalTo(-15)
            make.leading.equalTo(15)
        }
        
        cardTitle.snp.makeConstraints { make in
            make.top.equalTo(stackView).offset(230)
            make.centerX.equalToSuperview()
        }
    }
}
