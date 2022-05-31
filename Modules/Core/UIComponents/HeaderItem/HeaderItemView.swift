//
//  HeaderItemView.swift
//  UIComponents
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import UIKit

final public class HeaderItemView: UIView {
  
    enum Const {
        static let contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    // MARK: - Private properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Palatino-Bold", size: 20)
            label.textColor = UIColor.black
        return label
    }()

    
    // MARK: - Init
    
    public init(frame: CGRect = .zero, title: String) {
        super.init(frame: frame)
        
        titleLabel.text = title
        onInit()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
    
    // MARK: - Private methods
    
    private final func onInit() {
        layoutMargins = Const.contentInsets
        
        backgroundColor = .white
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(
                equalTo: layoutMarginsGuide.leadingAnchor
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: layoutMarginsGuide.trailingAnchor
            ),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

