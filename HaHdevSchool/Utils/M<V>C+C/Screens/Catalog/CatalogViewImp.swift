import UIKit

final class CatalogViewImp: UIView, CatalogView {
    
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
        addSubview(searchStackView)
        addSubview(titleStackView)
        addSubview(listFilterTitleButton)
        addSubview(displaySettingsStackView)
        addSubview(catalogCollectionView)
        
        NSLayoutConstraint.activate(
            [
                searchStackView.topAnchor.constraint(equalTo: topAnchor, constant: 57),
                searchStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 54),
                searchStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                
                titleStackView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor),
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
    
    //MARK: Search block
    
    lazy var materialSearch: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Catalog/TestSearch")
        return imageView
    }()
    
    lazy var advancedFilterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Catalog/AdvancedFilter"), for: .normal)
        button.backgroundColor = UIColor(named: "Colors/white")
        return button
    }()
    
    private var searchContainer: [UIView] {
        [
            materialSearch,
            advancedFilterButton
        ]
    }
    
    lazy var searchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: searchContainer)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
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
}

extension CatalogViewImp: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        160
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    
}
