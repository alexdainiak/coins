//
//  DashboardCoordinatorAssembly.swift
//  Coordinator
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Swinject

final class DashboardCoordinatorAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(DashboardCoordinator.self) { (_, navigationController: UINavigationController) in
            
            return DashboardCoordinator(navigationController: navigationController)
        }
    }
}
