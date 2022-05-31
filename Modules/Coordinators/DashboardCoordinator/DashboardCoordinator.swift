//
//  DashboardCoordinator.swift
//  Coordinator
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Coordinator
import Dashboard
import Domain
import Data


/// Coordinator, serving for routing to feature "Dashbord" and between other screens in this feature
class DashboardCoordinator: AssemblyCoordinator<Void> {
    
    private enum Consts {
        static let title = "Coins.ph"
    }
    
    var navigationController: UINavigationController!

    public override func assemblies() -> [Assembly] {
        [
            DashboardModuleAssembly(),
            WalletsDomainAssembly(),
            WalletsDataAssembly(),
            HistoryDataAssembly(),
            HistoryDomainAssembly()
        ]
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public override func start() {
        let module = resolver.resolve(DashboardModule.self)!
        
        module.input.title = Consts.title
        
        self.navigationController.pushViewController(module.view, animated: true)
    }
}
