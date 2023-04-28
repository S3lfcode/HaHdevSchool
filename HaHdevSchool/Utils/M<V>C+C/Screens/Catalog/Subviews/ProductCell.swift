import UIKit

final class ProductCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Setup subviews & constraints
    
    private func setup() {
        contentView.addSubview(placeholderImageView)
        contentView.addSubview(imageButtonStackView)
        contentView.addSubview(descProductStackView)
        contentView.addSubview(cartImageView)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate(
            [
                placeholderImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                placeholderImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                placeholderImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                imageButtonStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                imageButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                
                descProductStackView.topAnchor.constraint(equalTo: placeholderImageView.bottomAnchor, constant: 12),
                descProductStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                descProductStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                cartImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
                cartImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
    }
    
    //MARK: Image placeholder
    
    lazy var placeholderImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Catalog/ImagePlaceholder"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.backgroundColor = UIColor(named: "Colors/Phone/background")
        imageView.layer.cornerRadius = 10
        imageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        return imageView
    }()
    
    //MARK: Image buttons block
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Catalog/LikeOn"), for: .normal)
        button.contentMode = .center
        buttonSettings(button: button)
        return button
    }()
    
    lazy var scalesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Catalog/Scales"), for: .normal)
        button.tintColor = UIColor(named: "Colors/Phone/placeholder")
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        buttonSettings(button: button)
        return button
    }()
    
    private func buttonSettings(button: UIButton) {
        button.backgroundColor = UIColor(named: "Colors/white")
        button.layer.cornerRadius = 14
        button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowPath = UIBezierPath(rect: button.bounds).cgPath
        button.layer.shadowRadius = 8
        button.widthAnchor.constraint(equalToConstant: 28).isActive = true
        button.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    private var imageButtonContainer: [UIView] {
        [
            likeButton,
            scalesButton
        ]
    }
    
    lazy var imageButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: imageButtonContainer)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    //MARK: Description product block
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.22
        label.attributedText = NSMutableAttributedString(
            string: "Без названия",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont(name: "GothamSSm-Book", size: 13)
        return label
    }()
    
    private func generationRateContainer() -> [UIView] {
        var container: [UIView] = []
        for _ in 0..<5 {
            let imageView = UIImageView(image: UIImage(named: "Catalog/Rate"))
            imageView.tintColor = UIColor(named: "Colors/Grayscale/lightGray")
            container.append(imageView)
        }

        return container
    }
    
    private func fillRateStars(rating: Int) {
        for index in 0..<rating {
            rateStackView.arrangedSubviews[index].tintColor = UIColor(named: "Colors/Primary/blue")
        }
    }
    
    lazy var rateNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Colors/Grayscale/midGray")
        label.font = UIFont(name: "GothamSSm-Book", size: 12)
        label.text = "0.0"
        return label
    }()
    
    lazy var rateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: generationRateContainer())
        stackView.addArrangedSubview(rateNumLabel)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 3
        return stackView
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Colors/Grayscale/black")
        label.font = .systemFont(ofSize: 15, weight: .init(700))
        label.text = "0 ₽"
        return label
    }()
    
    private var descProductContainer: [UIView] {
        [
            titleLabel,
            rateStackView,
        ]
    }
    
    lazy var descProductStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: descProductContainer)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var cartImageView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Catalog/ShoppingCart"), for: .normal)
        button.contentHorizontalAlignment = .right
        button.backgroundColor = UIColor(named: "Colors/white")
        return button
    }()
}

//MARK: Setup sectionLayout
extension ProductCell {
    
    static func layout() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 16
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(324)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing/2, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = 24
        
        return section
    }
 
    func update(with data: ProductCellData) {
        titleLabel.text = data.title
        fillRateStars(rating: data.rating)
        rateNumLabel.text = " \(String(Double(data.rating)))"
        priceLabel.text = data.price
    }
}
