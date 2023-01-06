//  CardOfTheDayViewController.swift
//  tarot

import UIKit

struct DailyCardViewModel {
    var image: UIImage
    var zodiac: String
}

// протокол для взаимодействия с экраном карты
protocol DailyCardViewControllerProtocol {
    
    // сконфигурировать (показать контент) экран моделькой
    func configure(with model: DailyCardViewModel)
}

// экран карты дня
final class DailyCardViewController: UIViewController, DailyCardViewControllerProtocol {
    
    // MARK: - Переменные
    
    private let presenter: DailyCardPresenterProtocol
    private let gestureRecognizer = UITapGestureRecognizer()

    // MARK: - инициализация
    
    init(presenter: DailyCardPresenterProtocol){
        self.presenter = presenter
        // вызываем инициализатор родительского класса UIViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // конфигурация модельки
    func configure(with model: DailyCardViewModel) {
        dailyCardImage.image = model.image
        zodiac.text = model.zodiac
        
        // настройка анимации показа карты дня
        let transitionOptions = UIView.AnimationOptions.transitionFlipFromLeft
        UIView.transition(
            with: dailyCardImage,
            duration: 0.7,
            options: transitionOptions,
            animations: nil,
            completion: nil
        )
    }
    
    // метод для взаимодействия с презентером
    @objc func showDailyCard()  {
        presenter.didTapDaily()
    }
    
    private lazy var dailyCardImage = UIImageView()
    private lazy var zodiac = UILabel()
    private lazy var titleLabel = UILabel()

    // MARK: - layout
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        gestureRecognizer.addTarget(self, action: #selector(showDailyCard))
        
        view.addSubview(dailyCardImage)
        view.backgroundColor = .systemBackground
        dailyCardImage.clipsToBounds = true
        dailyCardImage.layer.cornerRadius = 20
        dailyCardImage.addGestureRecognizer(gestureRecognizer)
        dailyCardImage.isUserInteractionEnabled = true
        
        
        dailyCardImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.frame.height / 1/4)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.64)
            make.centerX.equalToSuperview()
        }

        view.addSubview(zodiac)
        zodiac.font = UIFont(name: "Yarin", size: 30)
        zodiac.snp.makeConstraints { make in
            make.top.equalTo(dailyCardImage).offset(view.frame.height / 1.94)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.text = "КТО ДУМАЛ О ТЕБЕ СЕГОДНЯ?"
        titleLabel.font = UIFont(name: "Yarin", size: 30)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.frame.height / 5.28)
            make.centerX.equalTo(dailyCardImage)
        }
    }
}
