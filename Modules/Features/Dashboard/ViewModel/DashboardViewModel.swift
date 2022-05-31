//
//  DashboardViewModel.swift
//  Dashboard
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Domain
import RxSwift
import RxCocoa
import CarbonKit

// MARK: - DashboardViewModel

public struct DashboardViewModelInput {
    
    // MARK: - Action
    
    public enum Action {
        case reload
        case start
    }
    
    // MARK: - Public properties
    
    public let action: Observable<Action>
    
    public init(action: Observable<DashboardViewModelInput.Action>) {
        self.action = action
    }
}

// MARK: - DashboardViewModelOutput

public struct DashboardViewModelOutput {
    
    public let title: Driver<String>
    public let content: Driver<[Section]>
    
    public init(
        title: Driver<String>,
        content: Driver<[Section]>
    ) {
        self.title = title
        self.content = content
    }
}

public protocol DashboardViewModel {
    func bind(input: DashboardViewModelInput) -> DashboardViewModelOutput
}
