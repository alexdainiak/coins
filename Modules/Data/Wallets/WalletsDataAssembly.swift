//
//  File.swift
//  Data
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Domain
import Swinject
import Moya
import Network

public class WalletsDataAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(WalletRepository.self) { _ in
            
            let errorTranslator = ErrorTranslators.Default<WalletError>(
                defaultCode: .failed,
                defaultMessage: "Failed to complete the operation"
            ).eraseToAnyErrorTranslator()
            
            return WalletsRepositoryImpl(
                provider: .init(),
                errorTranslator: errorTranslator
            )
        }
    }
    
}
