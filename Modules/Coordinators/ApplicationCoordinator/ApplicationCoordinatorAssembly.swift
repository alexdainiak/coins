//
//  ApplicationCoordinatorAssembly.swift
//  Coordinators
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Swinject

final public class ApplicationCoordinatorAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(ApplicationCoordinator.self) { (resolver, assembler: Assembler, navigationController: UINavigationController) in
            
            let applicationCoordinator = ApplicationCoordinator(assembler: assembler)
            
            applicationCoordinator.dashboardCoordinator = assembler.resolver.resolve(DashboardCoordinator.self, argument: navigationController)!
            return applicationCoordinator
        }
    }
}
