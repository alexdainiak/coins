//
//  ApplicationCoordinator.swift
//  ApplicationCoordinator
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Coordinator

/// First coordinator, from which starts routing in app
public class ApplicationCoordinator: RootCoordinator {
    
    var dashboardCoordinator: DashboardCoordinator!
    
    /// Helps to initialize required assemblies
    /// - Returns: array of all initialized assemblies
    public override func assemblies() -> [Assembly] {
        [
            DashboardCoordinatorAssembly()
        ]
    }
    
    public override init(assembler: Assembler) {
        super.init(assembler: assembler)
        
    }
    
    /// Starting dashboardCoordinator, routing to the feature "Dashboard"
    public override func start() {
        coordinate(to: dashboardCoordinator)
    }
}
