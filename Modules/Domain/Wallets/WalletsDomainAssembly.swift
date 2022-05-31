//
//  WalletsDomainAssembly.swift
//  Domain
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Swinject

public final class WalletsDomainAssembly: Assembly {
    
    public func assemble(container: Container) {
        container.register(WalletsUseCase.self) { resolver in
            
            let walletRepository = resolver.resolve(WalletRepository.self)!
            
            let walletsUseCase = WalletsUseCaseImpl(repository: walletRepository)
            
            return walletsUseCase
        }
    }
    
    public init() {}
}
