//
//  AnyErrorTranslator.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

public struct AnyErrorTranslator<ExpectedError: HierarchyError, ToError: HierarchyError>: ErrorTranslator
{
    private let base: Any?
    
    private let capturedTranslate: (Swift.Error) -> ToError
    
    public init<Base: ErrorTranslator>(_ base: Base)
        where
        Base.ExpectedError == ExpectedError,
        Base.ToError == ToError
    {
        self.base = base
        self.capturedTranslate = base.translate
    }
    
    public func translate(from error: Swift.Error) -> ToError {
        return capturedTranslate(error)
    }
}
