//
//  HistoryDataAssembly.swift
//  Data
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Domain
import Swinject
import Moya
import Network

public class HistoryDataAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(HistoryRepository.self) { _ in
            
            let errorTranslator = ErrorTranslators.Default<HistoryError>(
                defaultCode: .failed,
                defaultMessage: "Failed to complete the operation"
            ).eraseToAnyErrorTranslator()
            
            return HistoryRepositoryImpl(
                provider: .init(),
                errorTranslator: errorTranslator
            )
        }
    }
    
}
