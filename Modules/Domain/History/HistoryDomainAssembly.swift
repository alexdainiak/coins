//
//  HistoryDomainAssembly.swift
//  Domain
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//
import Swinject

public final class HistoryDomainAssembly: Assembly {
    
    public func assemble(container: Container) {
        container.register(HistoryUseCase.self) { resolver in
            
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            
            let historyUseCase = HistoryUseCaseImpl(repository: historyRepository)
            
            return historyUseCase
        }
    }
    
    public init() {}
}

