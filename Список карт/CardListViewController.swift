//  CardListViewController.swift
//  tarot

import UIKit

struct CardListItem {
    let image: UIImage
}

struct CardListViewModel {
    var sections: [(section: CardListSection, cards: [CardListItem])]
    
    static var empty: CardListViewModel {
        .init(sections: [])
    }
}

// протокол для взаимодействия с экраном списка карт
protocol CardListViewControllerProtocol {
    
    // сконфигурировать (показать контент) экран моделькой
    func configure(with model: CardListViewModel)
}

// экран со списком карт
final class CardListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CardListViewControllerProtocol {
    
    // MARK: - Переменные
    
    private let presenter: CardListPresenterProtocol
    
    // сначала ничего не показываем — пустая модель
    private var model = CardListViewModel.empty
    
    // MARK: - Init
    
    init(presenter: CardListPresenterProtocol) {
        self.presenter = presenter
        
        // вызываем инициализатор родительского класса UIViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Конфигурация вьюхи
    
    func configure(with model: CardListViewModel) {
        self.model = model
        collectionView.reloadData()
    }
    
    // MARK: - Создание коллекции
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
        collectionView.register(MajorArcanaHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MajorArcanaHeader.reuseId)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - layout
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.alwaysBounceVertical = true
    }
    
    // MARK: - Датасорс коллекции UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        model.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.sections[section].cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // создали ячейку
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath)
        
        // нашли нужную картинку
        let image = model.sections[indexPath.section].cards[indexPath.row].image
        
        // если ячейка является CardCell
        if let arcanaCell = cell as? CardCell {
            
            // то задаем ей картинку
            arcanaCell.configure(with: CardCell.Model(image: image))
        }
        
        // возвращаем подготовленную ячейку
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // переиспользуем заголовок
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MajorArcanaHeader.reuseId, for: indexPath)
        
        // если заголовок тот, который нам нужен
        if let arcanaHeader = header as? MajorArcanaHeader {
            
            // то конфигурируем его
            let title = CardListSection.allCases[indexPath.section].title
            arcanaHeader.configure(with: .init(text: title))
        }
        
        return header
    }
    
    // MARK: - Layout коллекции UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width / 7.5, height: size.height / 9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: 115, height: 120)
    }
    
    // MARK: - Делегат коллекции UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}
