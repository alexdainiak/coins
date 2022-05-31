//
//  WalletsUseCaseTestData.swift
//  Coins.phTests
//
//  Created by Дайняк Александр Николаевич on 01.05.2021.
//

import Domain
@testable import Coins_ph

/// Creating stub wallet model
extension Wallet: StubProtocol {

    static func stub(withId id: Int = 1) -> Self {
        return Wallet(
            id: String(id),
            walletName: "Wallet \(id)",
            balance: Amount(
                currency: .php,
                amount: 100
            )
        )
    }
}
