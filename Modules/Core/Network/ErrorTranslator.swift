//
//  ErrorTranslator.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

@_exported import AppFoundation
/// Use in reactive chains.
/// `subscribe (onError :), catchError (:)` and other `Rx` operators pass an error as` Swift.Error`,
/// overwriting its type.
/// This converter is adapted to work with similar situations.
/// It allows you to convert one error to another.
/// It is extremely convenient to use in layered architecture, where each layer has its own mistakes.
/// * `ToError` - Conversion result
/// * `ExpectedError` - Expected error. In the `translate (: _)` method we will try to cast
/// `Swift.Error` exactly in` ExpectedError`.
public protocol ErrorTranslator {
    associatedtype ToError: HierarchyError
    associatedtype ExpectedError: HierarchyError
    
    func translate(from error: Swift.Error) -> ToError
}

public extension ErrorTranslator {
    func eraseToAnyErrorTranslator() -> AnyErrorTranslator<ExpectedError, ToError> {
        return AnyErrorTranslator(self)
    }
}
