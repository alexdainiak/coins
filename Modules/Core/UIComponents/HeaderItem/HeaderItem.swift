//
//  HeaderItem.swift
//  UIComponents
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import CarbonKit

public struct HeaderItem: IdentifiableComponent {

    public let id: String

    let title: String
        
    public func renderContent() -> HeaderItemView {
        return .init(title: title)
    }
    
    public func render(in content: HeaderItemView) {
        content
    }
    
    public func referenceSize(in bounds: CGRect) -> CGSize? {
        return .init(
            width: bounds.width,
            height: 36
        )
    }
    
    public func shouldContentUpdate(with next: HeaderItem) -> Bool {
        return true
    }
    
    public init(
        id: String,
        title: String,
        icon: UIImage
    ) {
        self.id = id
        self.title = title
    }
    
    public init<T: RawRepresentable>(
        id: T,
        title: String
    ) where T.RawValue == String {
        self.id = id.rawValue
        self.title = title
    }
}
