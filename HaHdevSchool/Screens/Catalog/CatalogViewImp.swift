import UIKit

final class CatalogViewImp: UIView, CatalogView {
    
    private var cellData: [ProductCellData] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "Colors/white")
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        catalogCollectionView.contentInset.top = headerStackView.frame.height
    }
    
    //MARK: Setup subviews & constraints
    
    private func setup() {
        addSubview(catalogCollectionView)
        addSubview(headerStackView)
        addSubview(loadingImageView)
        
        NSLayoutConstraint.activate(
            [
                
                headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
                headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
                
                catalogCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                catalogCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                catalogCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                catalogCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                loadingImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                loadingImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
    }
    
    enum Constants {
        static let padding: CGFloat = 16
    }
    
    //MARK: Product title block
    
    private lazy var titleProducdsLabel: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.numberOfLines = 2
        label.font = UIFont(name: "GothamSSm-Medium", size: 20)
        label.textColor = UIColor(named: "Colors/Grayscale/black")
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private lazy var numberProductsLabel: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.font = UIFont(name: "GothamSSm-Book", size: 12)
        label.textColor = UIColor(named: "Colors/Grayscale/midGray")
        label.textAlignment = .right
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleProducdsLabel,
                numberProductsLabel
            ]
        )
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 64).isActive = true
        
        return stackView
    }()
    
    //MARK: Display settings block
    
    private lazy var listFilterTitleButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "Catalog/ListFilter"), for: .normal)
        button.setTitle("  По популярности", for: .normal)
        button.setTitleColor(UIColor(named: "Colors/Grayscale/black"), for: .normal)
        button.backgroundColor = UIColor(named: "Colors/white")
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: "GothamSSm-Medium", size: 14)
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        return button
    }()
    
    private lazy var scalesButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "Catalog/Scales"), for: .normal)
        button.tintColor = UIColor(named: "Colors/Grayscale/black")
        button.backgroundColor = UIColor(named: "Colors/white")
        
        return button
    }()
    
    private lazy var mappingModeButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "Catalog/MappingMode"), for: .normal)
        button.backgroundColor = UIColor(named: "Colors/white")
        
        return button
    }()
    
    private lazy var displaySettingsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                scalesButton,
                mappingModeButton
            ]
        )
        
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return stackView
    }()
    
    private lazy var settingsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                listFilterTitleButton,
                displaySettingsStackView
            ]
        )
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
       
        return stackView
    }()
    
    //MARK: Header stackView
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleStackView,
                settingsStackView
            ]
        )
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor(named: "Colors/white")
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        
        return stackView
    }()
    
    //MARK: Loading status block
    
    private lazy var loadingImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Auth/Loading")
        imageView.alpha = 0
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        return imageView
    }()
    
    func displayLoading(enable: Bool) {
        if !enable {
            catalogCollectionView.isUserInteractionEnabled = true
            headerStackView.isUserInteractionEnabled = true
            headerStackView.isHidden = false
            
            UIView.animate(withDuration: 0.2) {
                self.loadingImageView.alpha = 0
            }
            return
        }
        
        UIView.animate(withDuration: 0.2) {
            self.loadingImageView.alpha = 1
        }
        
        catalogCollectionView.isUserInteractionEnabled = false
        headerStackView.isUserInteractionEnabled = false
        headerStackView.isHidden = true
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.loadingImageView.transform = .init(rotationAngle: Double.pi/2)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.loadingImageView.transform = .init(rotationAngle: Double.pi)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.loadingImageView.transform = .init(rotationAngle: Double.pi*1.5)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.loadingImageView.transform = .init(rotationAngle: Double.pi*2)
            }
        })
    }
    
    //MARK: Products catalog block
    
    private lazy var catalogCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewCompositionalLayout { _, _ in
            ProductCell.layout()
        }
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    //MARK: Display data
    
    func display(
        cellData: [ProductCellData],
        titleData: ProductTitleData,
        animated: Bool
    ) {
        self.cellData = cellData
        
        titleProducdsLabel.text = titleData.title
        numberProductsLabel.text = "\(String(titleData.quantity)) товаров"
        
        catalogCollectionView.reloadData()
    }
    
}

//MARK: Calalog view settings

extension CatalogViewImp: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        cellData.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        if let cell = cell as? ProductCell {
            cell.update(with: cellData[indexPath.item])
        }
        
        return cell
    }
}

//MARK: Collection view logic

extension CatalogViewImp: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        cellData[indexPath.item].onSelect()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let diff = scrollView.contentInset.top + scrollView.contentOffset.y
        
        headerStackView.transform = .init(translationX: 0, y: -min(diff, titleStackView.frame.height))
    }
}
