//
//  EmptyDataItemView.swift
//  UIComponents
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

final public class EmptyDataItemView: UIView {
    
    // MARK: - Nested Types
    
    enum Const {
        static var horizontalInset: CGFloat { 20 }
        static var iconHeight: CGFloat { 24 }
        static var titleTrailingSpacing: CGFloat { -12 }
        static let numberOfLines = 3
        static let titleLabelFont = UIFont(name: "OpenSans-Bold", size: 14)
    }
    
    // MARK: - Public properties
    
    public override var intrinsicContentSize: CGSize {
        return .init(width: UIView.noIntrinsicMetric, height: 72)
    }
    
    // MARK: - Private properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ink
        label.font = Const.titleLabelFont
        label.numberOfLines = Const.numberOfLines
        return label
    }()
    
    private var tapClosure: (() -> Void)?
    
    private lazy var iconImageView = UIImageView()
    
    // MARK: - Init
    
    override public  init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupSubviews()
        setupGestureRecogniser()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Public methods
    
    func configure(with model: EmptyDataItem) {
        titleLabel.text = model.title
        iconImageView.image = model.icon
        tapClosure = model.tapClosure
    }
    
    // MARK: - Private methods
    
    private func setupGestureRecogniser() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tap() {
        tapClosure?()
    }
    
    private final func setupSubviews() {
        iconImageView.layer.masksToBounds = true
        
        addSubview(titleLabel)
        addSubview(iconImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Const.horizontalInset
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: iconImageView.leadingAnchor,
                constant: Const.titleTrailingSpacing
            ),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Const.iconHeight),
            iconImageView.heightAnchor.constraint(equalToConstant: Const.iconHeight),
            iconImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Const.horizontalInset
            ),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

