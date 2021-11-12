import UIKit
import ThemeKit
import SnapKit

class CircleCautionView: UIView {
    private let stackView = UIStackView()

    private let circleView = UIView()
    private let imageView = UIImageView()
    private let captionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = .margin32

        circleView.snp.makeConstraints { maker in
            maker.size.equalTo(100)
        }

        circleView.isHidden = true
        circleView.backgroundColor = .themeRaina
        circleView.layer.cornerRadius = 50

        circleView.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.center.equalTo(circleView)
        }

        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)

        stackView.addArrangedSubview(circleView)

        stackView.addArrangedSubview(captionLabel)

        captionLabel.numberOfLines = 0
        captionLabel.textAlignment = .center
        captionLabel.font = .subhead2
        captionLabel.textColor = .themeGray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var spacing: CGFloat {
        get { stackView.spacing }
        set { stackView.spacing = newValue }
    }

    var image: UIImage? {
        get { imageView.image }
        set {
            imageView.image = newValue
            circleView.isHidden = newValue == nil
        }
    }

    var text: String? {
        get { captionLabel.text }
        set {
            captionLabel.text = newValue
            captionLabel.isHidden = newValue == nil
        }
    }

    var textColor: UIColor {
        get { captionLabel.textColor }
        set { captionLabel.textColor = newValue }
    }

    var font: UIFont {
        get { captionLabel.font }
        set { captionLabel.font = newValue }
    }

}
