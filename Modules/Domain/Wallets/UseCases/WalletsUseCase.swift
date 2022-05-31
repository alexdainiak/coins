//
//  WalletsUseCase.swift
//  Domain
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import RxSwift
import RxCocoa

/// Use case protocol for getting wallets list
public protocol WalletsUseCase {
    var result: BehaviorRelay<DataState<[Wallet], DomainError<WalletError>>> { get }
    
    func reload()
}
