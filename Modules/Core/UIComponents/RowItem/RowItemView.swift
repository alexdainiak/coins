//
//  RowItemView.swift
//  UIComponents
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import UIKit

// MARK: - RowItemView

final public class RowItemView: UIView {
    
    // MARK: - Nested Types
    
    private enum Consts {
        
        enum Sizes {
            static var horizontalInset: CGFloat { 20 }
            static var titleTrailingSpacing: CGFloat { -12 }
        }
        
        enum Colors {
            public static let titleColor: UIColor = .ink
            public static let subTitleColor: UIColor = .darkLightGray
        }
        
        enum Fonts {
            public static let titleFont = UIFont(name: "Palatino", size: 18)
            public static let subTitleFont = UIFont(name: "Palatino-Bold", size: 17)
        }
    }
    
    // MARK: - Private properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Consts.Fonts.titleFont
        label.textColor = Consts.Colors.titleColor
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Consts.Fonts.subTitleFont
        label.textColor = Consts.Colors.subTitleColor
        
        return label
    }()
    
    // MARK: - Init
    
    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure(with model: RowItem) {
        titleLabel.text = model.title
        balanceLabel.text = model.balance
        balanceLabel.isHidden = model.balance?.isEmpty ?? true
    }
    
    // MARK: - Private methods
    
    private func setupSubviews() {
        
        addSubview(titleLabel)
        addSubview(balanceLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        balanceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Consts.Sizes.horizontalInset
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: balanceLabel.leadingAnchor,
                constant: Consts.Sizes.titleTrailingSpacing
            ),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            balanceLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Consts.Sizes.horizontalInset
            ),
            balanceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
}

