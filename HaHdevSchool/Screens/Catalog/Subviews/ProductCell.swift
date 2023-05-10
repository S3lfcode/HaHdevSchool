import UIKit
import Kingfisher

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
        contentView.addSubview(productImageView)
        contentView.addSubview(imageButtonStackView)
        contentView.addSubview(descProductStackView)
        contentView.addSubview(cartButton)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate(
            [
                productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                imageButtonStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                imageButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                
                descProductStackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 12),
                descProductStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                descProductStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
                cartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
    }
    
    //MARK: Product image block
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView(image: Asset.Catalog.imagePlaceholder.image)
        
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.backgroundColor = Asset.Colors.Phone.background.color
        imageView.layer.cornerRadius = 10
        imageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        return imageView
    }()
    
    private func updateProductImage(url: String?) {
        guard let stringURL = url else {
            return
        }
        
        let url = URL(string: stringURL)

        productImageView.kf.indicatorType = .activity
        productImageView.kf.setImage(
            with: url,
            placeholder: Asset.Catalog.imagePlaceholder.image,
            options: [
                .transition(.fade(0.2)),
                .processor(
                    DownsamplingImageProcessor(
                        size: CGSize(width: bounds.width, height: 220)
                    )
                )
            ]
        )
    }
    
    //MARK: Like&Scale buttons block
    lazy var likeButton: UIButton = {
        let button = UIButton()
        
        button.setImage(Asset.Catalog.likeOff.image, for: .normal)
        button.setImage(Asset.Catalog.likeOn.image, for: .selected)
        button.tintColor = Asset.Colors.Phone.placeholder.color
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
        imageView.image = Asset.Auth.loading.image
        imageView.alpha = 0
        imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        return imageView
    }()
    
    lazy var scalesButton: UIButton = {
        let button = UIButton()
        
        button.setImage(Asset.Catalog.scalesOff.image, for: .normal)
        button.setImage(Asset.Catalog.scalesOn.image, for: .selected)
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
        button.backgroundColor = Asset.Colors.white.color
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
    
    lazy var imageButtonStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews:
                [
                    likeButton,
                    scalesButton
                ]
        )
        
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
    
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.22
        label.numberOfLines = 2
        label.attributedText = NSMutableAttributedString(
            string: L10n.Catalog.ProductCell.unnamed,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont(name: "GothamSSm-Book", size: 13)
        
        return label
    }()
    
    private func generationRateContainer() -> [UIView] {
        var container: [UIView] = []
        
        for _ in 0..<5 {
            let imageView = UIImageView(image: Asset.Catalog.rate.image)
            imageView.tintColor = Asset.Colors.Grayscale.lightGray.color
            container.append(imageView)
        }
        
        return container
    }
    
    private func fillRateStars(rating: Int) {
        for element in rateStackView.arrangedSubviews {
            element.tintColor = Asset.Colors.Grayscale.lightGray.color
        }
        for index in 0..<rating {
            rateStackView.arrangedSubviews[index].tintColor = Asset.Colors.Primary.blue.color
        }
    }
    
    lazy var rateNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.Grayscale.midGray.color
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
        label.textColor = Asset.Colors.Grayscale.black.color
        label.font = .systemFont(ofSize: 15, weight: .init(700))
        label.text = L10n.Catalog.ProductCell.defaultPrice
        return label
    }()
    
    lazy var descProductStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews:
                [
                    titleLabel,
                    rateStackView,
                ]
        )
        
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
        button.setImage(Asset.Catalog.shoppingCart.image, for: .normal)
        button.setImage(Asset.Catalog.shoppingCartAdded.image, for: .selected)
        button.contentHorizontalAlignment = .right
        button.backgroundColor = Asset.Colors.white.color
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
    
    //MARK: Update cell function
    func update(with data: ProductCellData) {
        titleLabel.text = data.name ?? L10n.Catalog.ProductCell.unnamed
        fillRateStars(rating: data.rating ?? 0)
        rateNumLabel.text = " \(String(Double(data.rating ?? 0)))"
        priceLabel.text = data.price ?? L10n.Catalog.ProductCell.defaultPrice
        updateProductImage(url: data.image)

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

//MARK: Display likeButton loading
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
