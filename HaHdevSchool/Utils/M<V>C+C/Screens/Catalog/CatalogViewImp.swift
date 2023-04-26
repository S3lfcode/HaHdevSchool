import UIKit

final class CatalogViewImp: UIView, CatalogView {
    
    var onBack: (() -> Void)?
    
    var onSettings: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "Colors/white")
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup subviews & constraints
    
    private func setup() {
        addSubview(titleStackView)
        addSubview(listFilterTitleButton)
        addSubview(displaySettingsStackView)
        addSubview(catalogCollectionView)
        
        NSLayoutConstraint.activate(
            [
                titleStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                titleStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
                titleStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
                
                listFilterTitleButton.topAnchor.constraint(equalTo: titleStackView.bottomAnchor),
                listFilterTitleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
                
                displaySettingsStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor),
                displaySettingsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
                
                catalogCollectionView.topAnchor.constraint(equalTo: displaySettingsStackView.bottomAnchor),
                catalogCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                catalogCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                catalogCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }

    enum Constants {
        static let padding: CGFloat = 16
    }
    
    //MARK: Product title block
    
    lazy var titleProducdsLabel: UILabel = {
        let label = UILabel()
        label.text = "Женские толстовки"
        label.numberOfLines = 2
        label.font = UIFont(name: "GothamSSm-Medium", size: 20)
        label.textColor = UIColor(named: "Colors/Grayscale/black")
        return label
    }()
    
    lazy var numberProductsLabel: UILabel = {
        let label = UILabel()
        label.text = "160 товаров"
        label.font = UIFont(name: "GothamSSm-Book", size: 12)
        label.textColor = UIColor(named: "Colors/Grayscale/midGray")
        label.textAlignment = .right
        return label
    }()
    
    private var titleContainer: [UIView] {
        [
        titleProducdsLabel,
        numberProductsLabel
        ]
    }
    
    lazy var titleStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: titleContainer)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 64).isActive = true
        return stackView
    }()
    
    //MARK: Display settings block
    
    lazy var listFilterTitleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Catalog/ListFilter"), for: .normal)
        button.setTitle("  По популярности", for: .normal)
        button.setTitleColor(UIColor(named: "Colors/Grayscale/black"), for: .normal)
        button.backgroundColor = UIColor(named: "Colors/white")
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: "GothamSSm-Medium", size: 14)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()
    
    lazy var scalesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Catalog/Scales"), for: .normal)
        button.tintColor = UIColor(named: "Colors/Grayscale/black")
        button.backgroundColor = UIColor(named: "Colors/white")
        return button
    }()
    
    lazy var mappingModeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Catalog/MappingMode"), for: .normal)
        button.backgroundColor = UIColor(named: "Colors/white")
        return button
    }()
    
    private var displaySettingsContainer: [UIView] {
        [
            scalesButton,
            mappingModeButton
        ]
    }
    
    lazy var displaySettingsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: displaySettingsContainer)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return stackView
    }()
    
    //MARK: Products catalog block
    
    lazy var catalogCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewCompositionalLayout { _, _ in
            ProductCell.layout()
        }
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        return collectionView
    }()
    
    @objc func toBack(sender: UIBarButtonItem) {
        onBack?()
    }
    
    @objc func toSettings(sender: UIBarButtonItem) {
        onSettings?()
    }
}

//MARK: Configuration navigation controller

extension CatalogViewImp {
    
    func configureNavController(navItem: UINavigationItem) {
        
        let backButton = UIBarButtonItem(
            image: UIImage(named: "Auth/backButton"),
            style: .done,
            target: self,
            action: #selector(toBack(sender:))
        )
        backButton.tintColor = UIColor(named: "Colors/Grayscale/black")
        navItem.leftBarButtonItem = backButton
        
        let settingsButton = UIBarButtonItem(
            image: UIImage(named: "Catalog/AdvancedFilter"),
            style: .done,
            target: self,
            action: #selector(toSettings(sender:))
        )
        settingsButton.tintColor = UIColor(named: "Colors/Grayscale/black")
        navItem.rightBarButtonItem = settingsButton
        
        navItem.titleView = UIImageView(image: UIImage(named: "Catalog/TestSearch"))
    }
    
}

//MARK: Calalog view settings

extension CatalogViewImp: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        160
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
}
