//
//  DomainError.swift
//  Domain
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import AppFoundation

// MARK: - DomainError

public struct DomainError<ErrorCode>: HierarchyError {
    
    // MARK: - Public properties
    
    public var errorCode: String {
        return String(describing: code)
    }
    
    public var parentHierarchyError: HierarchyError?

    public let code: ErrorCode
    public let message: String
    
    // MARK: - Init
    
    public init(
        code: ErrorCode,
        message: String,
        parentHierarchyError: HierarchyError?
    ) {
        self.code = code
        self.message = message
        self.parentHierarchyError = parentHierarchyError
    }
}

extension DomainError: Equatable {
    
    public static func == (lhs: DomainError<ErrorCode>, rhs: DomainError<ErrorCode>) -> Bool {
        lhs.errorCode == rhs.errorCode
    }
}
