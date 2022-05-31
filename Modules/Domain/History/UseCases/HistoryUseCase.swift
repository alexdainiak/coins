//
//  HistoryUseCase.swift
//  Domain
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//
import RxSwift
import RxCocoa

/// Use case protocol for getting history
public protocol HistoryUseCase {
    var result: BehaviorRelay<DataState<[History], DomainError<HistoryError>>> { get }

    func reload()
}
