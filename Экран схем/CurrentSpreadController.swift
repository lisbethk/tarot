import SnapKit
import UIKit

struct SpreadListItem {
    let image: UIImage
    let description: String
    let title: String
}

struct CurrentSpreadViewModel {
    var items: [SpreadListItem]
    
    static var empty: CurrentSpreadViewModel {
        .init(items: [])
    }
}

protocol CurrentSpreadViewControllerProtocol {
    
    // сконфигурировать (показать контент) экран моделькой
    func configure(with model: CurrentSpreadViewModel)
}

final class CurrentSpreadViewController:
        UIViewController,
        UICollectionViewDataSource,
        UICollectionViewDelegate,
        UICollectionViewDelegateFlowLayout,
        CurrentSpreadViewControllerProtocol {
    
    private let presenter: CurrentSpreadPresenterProtocol
    private var model = CurrentSpreadViewModel.empty
    
    
    // MARK: - Init
    
    init(presenter: CurrentSpreadPresenterProtocol) {
        self.presenter = presenter
        
        // вызываем инициализатор родительского класса UIViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configure(with model: CurrentSpreadViewModel) {
        self.model = model
        collectionView.reloadData()
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        
        collectionView.register(SpreadCell.self,
                                forCellWithReuseIdentifier: SpreadCell.identifier)

        
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        let colletionFlowLayout = basicListLayout()
        collectionView.collectionViewLayout = colletionFlowLayout
        navigationItem.largeTitleDisplayMode = .never
        collectionView.alwaysBounceVertical = true
    }
    
    func basicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // создали ячейку
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpreadCell.identifier, for: indexPath)
        
        // нашли нужную картинку
        let image = model.items[indexPath.row].image
        let description = model.items[indexPath.row].description
        let name = model.items[indexPath.row].title
        
        // если ячейка является SpreadCell
        if let spreadCell = cell as? SpreadCell {
            
            // то задаем ей картинку
            spreadCell.configure(with: SpreadCell.Model(image: image,
                                                        description: description,
                                                        title: name))
        }
        return cell
    }
}

