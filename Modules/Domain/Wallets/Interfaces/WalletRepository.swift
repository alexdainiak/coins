//
//  WalletRepository.swift
//  Domain
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import RxSwift

public protocol WalletRepository {
    func getWallets() -> Single<[Wallet]>
}
