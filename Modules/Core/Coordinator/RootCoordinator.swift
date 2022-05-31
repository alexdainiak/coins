//
//  RootCoordinator.swift
//  Coordinator
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Swinject

/// Root Coordinator of app, collects every assembly which helps to resolve required objects
open class RootCoordinator: AssemblyCoordinator<Void> {
    
    public init(assembler: Assembler) {
        super.init()
        
        self.assembler = assembler
        assembler.apply(assemblies: assemblies())
    }
    
}
