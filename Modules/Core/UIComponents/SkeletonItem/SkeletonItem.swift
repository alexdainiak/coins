//
//  SkeletonItem.swift
//  UIComponents
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import CarbonKit

public struct SkeletonItem: IdentifiableComponent {
    
    public func shouldContentUpdate(with next: SkeletonItem) -> Bool {
        return true
    }
    
    
    public let id: String
        
    public func renderContent() -> SkeletonItemView {
        return .init()
    }
    
    public func referenceSize(in bounds: CGRect) -> CGSize? {
        return .init(
            width: UIView.noIntrinsicMetric,
            height: 56
        )
    }
    
    public init(id: String) {
        self.id = id
    }
    
    public init<T: RawRepresentable>(id: T) where T.RawValue == String {
        self.id = id.rawValue
    }
    
    public func render(in content: SkeletonItemView) {
        content.startSkeleton()
    }
    
    public func contentDidEndDisplay(_ content: SkeletonItemView) {
        content.stopSkeleton()
    }
}

