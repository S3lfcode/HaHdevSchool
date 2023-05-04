import UIKit

final class ProductCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var onSelectLike: (() -> Void)?
    
    //MARK: Setup subviews & constraints
    
    private func setup() {
        contentView.addSubview(placeholderImageView)
        contentView.addSubview(imageButtonStackView)
        contentView.addSubview(descProductStackView)
        contentView.addSubview(cartButton)
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
                
                cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
                cartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
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
        button.setImage(UIImage(named: "Catalog/LikeOff"), for: .normal)
        button.setImage(UIImage(named: "Catalog/LikeOn"), for: .selected)
        button.tintColor = UIColor(named: "Colors/Phone/placeholder")
        button.contentMode = .center
        button.addTarget(self, action: #selector(selectLike), for: .touchUpInside)
        button.addSubview(loadingImageView)
        loadingImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        loadingImageView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        buttonSettings(button: button)
        return button
    }()
    
    private lazy var loadingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Auth/Loading")
        imageView.alpha = 0
        imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        return imageView
    }()
    
    lazy var scalesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Catalog/ScalesOff"), for: .normal)
        button.setImage(UIImage(named: "Catalog/ScalesOn"), for: .selected)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        button.addTarget(self, action: #selector(selectButton(sender:)), for: .touchUpInside)
        buttonSettings(button: button)
        return button
    }()
    
    private func buttonSettings(button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 28).isActive = true
        button.heightAnchor.constraint(equalToConstant: 28).isActive = true
        button.backgroundColor = UIColor(named: "Colors/white")
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 14
        button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1/10)
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 8
        button.layer.shadowPath = UIBezierPath(
            roundedRect: .init(
                origin: button.bounds.origin,
                size: .init(
                    width: 28,
                    height: 28
                )
            ),
            cornerRadius: 0
        ).cgPath
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
    
    lazy var cartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Catalog/ShoppingCart"), for: .normal)
        button.setImage(UIImage(named: "Catalog/ShoppingCartAdded"), for: .selected)
        button.contentHorizontalAlignment = .right
        button.backgroundColor = UIColor(named: "Colors/white")
        button.addTarget(self, action: #selector(selectButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc func selectButton(sender: UIButton){
        switch sender.isSelected {
        case true:
            sender.isSelected = false
        case false:
            sender.isSelected = true
        }
    }
    
    @objc func selectLike(){
        onSelectLike?()
    }
    
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
        
        data.onFavoriteSubscriber(self) { [weak self] state in
            
            self?.updateLikeButtonState(state: state)
        }
        onSelectLike = data.onFavoriteSelect
    }
}

//MARK: Update button state
private extension ProductCell {
    func updateLikeButtonState(state: CellButtonState) {
        if state.isLoading {
            displayLoading(enable: true)
        } else {
            displayLoading(enable: false)
        }
        
        if state.isSelected {
            likeButton.isSelected = true
        } else {
            likeButton.isSelected = false
        }
    }
}

//MARK: display loading
private extension ProductCell {
    func displayLoading(enable: Bool) {
        
        if !enable {
            likeButton.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.loadingImageView.alpha = 0
                self.likeButton.imageView?.layer.transform = CATransform3DIdentity
            }
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.likeButton.imageView?.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
        }
        UIView.animate(withDuration: 0.2, delay: 0.2) {
            self.loadingImageView.alpha = 1
        }
        
        likeButton.isUserInteractionEnabled = false
        
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
}
