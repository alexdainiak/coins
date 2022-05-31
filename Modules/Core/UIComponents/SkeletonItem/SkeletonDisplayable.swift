//
//  SkeletonDisplayable.swift
//  UIComponents
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import Foundation

struct GradientLayerParams {
    
    let startPoint: CGPoint
    let endPoint: CGPoint
    let toValue: [CGFloat]
    let fromValue: [CGFloat]
    let loacations: [Float]
    
    static let shimmer: Self = .init(
        startPoint: CGPoint(x: 0.0, y: 1.0),
        endPoint: CGPoint(x: 1.0, y: 1.0),
        toValue: [1.0, 1.5, 2.0],
        fromValue: [-1.0, -0.5, 0.0],
        loacations: [0.0, 0.5, 1.0]
    )
}

enum SkeletonDisplayableType {
    
    case flickering(duration: TimeInterval = 0.9)
    case gradient(
            duration: TimeInterval = 0.9,
            params: GradientLayerParams = .shimmer,
            highlightColor: UIColor = UIColor.lightGray.withAlphaComponent(0.35)
         )
}

extension SkeletonDisplayableType {
    var keyPath: String {
        switch self {
            case .flickering:
                return "opacity"
            case .gradient:
                return "locations"
        }
    }
}

protocol SkeletonDisplayable {
    func startSkeleton(with type: SkeletonDisplayableType)
    func stopSkeleton(with type: SkeletonDisplayableType)
}

extension SkeletonDisplayable where Self: UIView {
    
    func startSkeleton(with type: SkeletonDisplayableType = .flickering()) {
        
        switch type {
            case let .flickering(duration):
                addFlickeringAnimation(duration: duration, keyPath: type.keyPath)
            case .gradient(let duration, let params, let highlightColor):
                
                CATransaction.begin()
                CATransaction.setAnimationDuration(duration)
                
                addGradientAnimation(
                    params: params,
                    duration: duration,
                    highlightColor: highlightColor,
                    keyPath: type.keyPath
                )
                
                CATransaction.commit()
        }
    }
    
    func stopSkeleton(with type: SkeletonDisplayableType = .flickering()) {
        switch type {
            case .flickering:
                subviews.filter {
                    $0.layer.animation(forKey: type.keyPath) != nil
                }.forEach {
                    $0.layer.removeAllAnimations()
                }
            case .gradient:
                subviews.compactMap {
                    $0.layer.mask
                }
                .filter { $0.animation(forKey: type.keyPath) != nil }
                .forEach {
                    $0.removeAllAnimations()
                    $0.removeFromSuperlayer()
                }
        }
    }
    
    private func addFlickeringAnimation(
        duration: TimeInterval,
        keyPath: String
    ) {
        subviews.forEach { view in
            let flickering = CABasicAnimation(keyPath: keyPath)
            flickering.duration = duration
            flickering.fromValue = 1
            flickering.toValue = 0.35
            flickering.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            flickering.autoreverses = true
            flickering.repeatCount = .infinity
            
            view.layer.add(flickering, forKey: flickering.keyPath)
        }
    }
    
    private func addGradientAnimation(
        params: GradientLayerParams,
        duration: TimeInterval,
        highlightColor: UIColor,
        keyPath: String
    ) {
        subviews.forEach { view in
            
            let gradientLayer = CAGradientLayer()
            
            let colors = [
                view.backgroundColor?.cgColor,
                highlightColor.cgColor,
                view.backgroundColor?.cgColor
            ].compactMap { $0 }
            
            gradientLayer.frame = view.bounds
            gradientLayer.startPoint = params.startPoint
            gradientLayer.endPoint = params.endPoint
            gradientLayer.colors = colors
            gradientLayer.locations = params.loacations.compactMap { NSNumber(value: $0) }
            
            view.layer.mask = gradientLayer
            view.clipsToBounds = true
            
            let animation = CABasicAnimation(keyPath: keyPath)
            animation.fromValue = params.fromValue
            animation.toValue = params.toValue
            animation.repeatCount = .infinity
            animation.duration = duration
            
            gradientLayer.add(animation, forKey: animation.keyPath)
        }
    }
}

extension UIView {
    
    func skeletonViews() -> [SkeletonDisplayable] {
        return recursivelyView.compactMap { $0 as? SkeletonDisplayable }
    }
    
    private var recursivelyView: [UIView] {
        var subviews = self.subviews
        subviews.append(contentsOf: self.subviews.flatMap({ $0.recursivelyView }))
        
        return subviews
    }
    
}

