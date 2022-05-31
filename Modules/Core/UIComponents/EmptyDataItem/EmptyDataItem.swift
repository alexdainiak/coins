//
//  EmptyDataItem.swift
//  UIComponents
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import CarbonKit


public struct EmptyDataItem: IdentifiableComponent {

    public let id: String

    let title: String
    let icon: UIImage
    let tapClosure: (() -> Void)
        
    public func renderContent() -> EmptyDataItemView {
        return .init()
    }
    
    public func render(in content: EmptyDataItemView) {
        content.configure(with: self)
    }
    
    public func referenceSize(in bounds: CGRect) -> CGSize? {
        return .init(
            width: bounds.width,
            height: 72
        )
    }
    
    public func shouldContentUpdate(with next: EmptyDataItem) -> Bool {
        return true
    }
    
    init(
        id: String,
        title: String,
        icon: UIImage,
        tapIcon: @escaping (() -> Void)
    ) {
        self.id = id
        self.title = title
        self.icon = icon
        self.tapClosure = tapIcon
    }
    
    init<T: RawRepresentable>(
        id: T,
        title: String,
        icon: UIImage,
        tapIcon: @escaping (() -> Void)
    ) where T.RawValue == String {
        self.id = id.rawValue
        self.title = title
        self.icon = icon
        self.tapClosure = tapIcon
    }
}

extension EmptyDataItem {
    public static var forWallets: EmptyDataItem {
        return .init(
            id: "forWallets",
            title: "Create a wallet with any currency \nor cryptocurrency",
            icon: UIImage(systemName: "folder.fill.badge.plus") ?? UIImage(),
            tapIcon: { print("Add wallet tapped") }
        )
    }
    
    public static func errorWallet(message: String) -> EmptyDataItem {
        return .init(
            id: "errorWallets",
            title: "Unfortunately an error in the Wallet service - \(message)",
            icon: UIImage(systemName: "xmark.octagon") ?? UIImage(),
            tapIcon: { }
        )
    }
    
    public static func errorHistory(message: String) -> EmptyDataItem {
        return .init(
            id: "errorHistory",
            title: "Unfortunately an error in the History service - \(message)",
            icon: UIImage(systemName: "xmark.octagon") ?? UIImage(),
            tapIcon: { }
        )
    }
    
    public static var forHistory: EmptyDataItem {
        return .init(
            id: "forHistory",
            title: "Operation list is empty",
            icon: UIImage(systemName: "list.bullet.rectangle") ?? UIImage(),
            tapIcon: { print("history tapped") }
        )
    }
}
