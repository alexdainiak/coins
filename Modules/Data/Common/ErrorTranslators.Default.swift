//
//  ErrorTranslators.Default.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import Domain
import AppFoundation
import Network

extension ErrorTranslators {
    public final class Default<DomainErrorCode>: ErrorTranslator
    where
        DomainErrorCode: RawRepresentable,
        DomainErrorCode.RawValue == String
    {
        public typealias ToError = DomainError<DomainErrorCode>
        public typealias ExpectedError = ApiErrorModel
        
        public let defaultCode: DomainErrorCode
        public let defaultMessage: String
        
        public init(
            defaultCode: DomainErrorCode,
            defaultMessage: String
        ) {
            self.defaultCode = defaultCode
            self.defaultMessage = defaultMessage
        }
        
        public func translate(from error: Error) -> DomainError<DomainErrorCode> {
            guard let expectedError = error as? ExpectedError else { return makeDefault(with: error) }
            
            if let code = DomainErrorCode(rawValue: expectedError.code) {
                return DomainError(
                    code: code,
                    message: expectedError.message,
                    parentHierarchyError: expectedError
                )
            } else {
                return makeDefault(with: expectedError)
            }
        }
        
        private func makeDefault(with underlying: Swift.Error) -> DomainError<DomainErrorCode> {
            return DomainError(
                code: defaultCode,
                message: defaultMessage,
                parentHierarchyError: underlying as? HierarchyError
            )
        }
    }
}

