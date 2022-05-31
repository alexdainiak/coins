//
//  HierarchyError.swift
//  AppFoundation
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import SwiftUI

public protocol FeatureModule: AnyObject {

    associatedtype Input

    associatedtype Output
    
    var view: UIViewController { get }

    var input: Input { get }

    var output: Output { get }
}

open class BaseModule<Input, Output>: FeatureModule {

    // MARK: - Public
    
    public let view: UIViewController
    public var output: Output
    public var input: Input

    // MARK: - Init
    
    public init(
        view: UIViewController,
        input: Input,
        output: Output
    ) {
        self.view = view
        self.input = input
        self.output = output
    }
}
