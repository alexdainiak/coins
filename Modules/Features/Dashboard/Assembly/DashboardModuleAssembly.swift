//
//  DashboardModuleAssembly.swift
//  Pods
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Swinject
import  Domain


/// Assembler of Dahboard Module with ViewModel and ViewController
public final class DashboardModuleAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(DashboardModule.self) { resolver in
            
            let walletsUseCase = resolver.resolve(WalletsUseCase.self)!
            let historyUseCase = resolver.resolve(HistoryUseCase.self)!
            
            let viewModel = DashboardViewModelImpl(
                historyUseCase: historyUseCase,
                walletsUseCase: walletsUseCase
            )
            let view = DashboardViewController(viewModel: viewModel)
            
            return DashboardModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
    
    public init() {}
}

