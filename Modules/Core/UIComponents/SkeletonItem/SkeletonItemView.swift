//
//  SkeletonItemView.swift
//  UIComponents
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import UIKit

final public class SkeletonItemView: UIView, SkeletonDisplayable {
    
    // MARK: - Nested Types
    
    enum Const {
        static let contentInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        static var rightIconSize: CGSize { .init(width: 80, height: 20) }
        static var titleWidthMultiplier: CGFloat { 0.6 }
        static var subtitleWidthMultiplier: CGFloat { 0.37 }
        static var titleHeight: CGFloat { 16 }
        static var cornerRadius: CGFloat { 3 }
        static var interItemsSpace: CGFloat { 6 }
    }
    
    // MARK: - Private properties
    
    private let titleView = UIView()
    private let subtitleView = UIView()
    private let rightIconView = UIView()
    
    private lazy var views = [
        titleView,
        subtitleView,
        rightIconView
    ]
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubview()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { return nil }
    
    // MARK: - Life Cycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        titleView.layer.cornerRadius = Const.cornerRadius
        subtitleView.layer.cornerRadius = Const.cornerRadius
        rightIconView.layer.cornerRadius = Const.cornerRadius
    }
    
    // MARK: - Private methods
    
    private func setupSubview() {
        backgroundColor = .white
        
        layoutMargins = Const.contentInsets
        
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
            view.backgroundColor = .lightGray
        }
        
        NSLayoutConstraint.activate([
            titleView.heightAnchor.constraint(equalToConstant: Const.titleHeight),
            titleView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            titleView.bottomAnchor.constraint(
                equalTo: subtitleView.topAnchor,
                constant: -Const.interItemsSpace
            ),
            titleView.widthAnchor.constraint(
                equalTo: layoutMarginsGuide.widthAnchor,
                multiplier: Const.titleWidthMultiplier
            ),
            
            subtitleView.heightAnchor.constraint(equalToConstant: Const.titleHeight),
            subtitleView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            subtitleView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            subtitleView.widthAnchor.constraint(
                equalTo: layoutMarginsGuide.widthAnchor,
                multiplier: Const.subtitleWidthMultiplier
            ),
            
            rightIconView.widthAnchor.constraint(equalToConstant: Const.rightIconSize.width),
            rightIconView.heightAnchor.constraint(equalToConstant: Const.rightIconSize.height),
            rightIconView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            rightIconView.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor)
        ])
    }
}
