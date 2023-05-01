import UIKit

class AuthSocialMediaButton: UIButton {
    
    enum Constants {
        static let side: CGFloat = 46
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(socialMediaImageView)
        layer.cornerRadius = Constants.side/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage?, color: UIColor?) {
        guard let image = image, let color = color
        else {return}
        socialMediaImageView.image = image
        backgroundColor = color
    }
    
    override var intrinsicContentSize: CGSize {
        .init(
            width: Constants.side,
            height: Constants.side
        )
    }
    
    private lazy var socialMediaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = .center
        return imageView
    }()
}
