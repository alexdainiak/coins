//
//  RowItem.swift
//  UIComponents
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import CarbonKit

// MARK: - RowItem

/// View model for displaying title and balance
public struct RowItem  {
    
    // MARK: - Initializable
    
    public var id: AnyHashable {
        title
    }
    var title: String
    var balance: String?
    
    // MARK: - Initializers
    
    public init(
        title: String,
        balance: String? = nil
    ) {
        self.title = title
        self.balance = balance
    }
}

extension RowItem: IdentifiableComponent{
    public func referenceSize(in bounds: CGRect) -> CGSize? {
        
        return .init(
            width: bounds.width,
            height: 56
        )
    }
    
    public func shouldContentUpdate(with next: RowItem) -> Bool {
        return true
    }
    
    
    // MARK: - Public methods
    
    public func renderContent() -> RowItemView {
        return RowItemView()
    }
    
    public func render(in content: RowItemView) {
        content.configure(with: self)
    }
    
}
