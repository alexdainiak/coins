//
//  HistoryUseCaseTestData.swift
//  Coins.phTests
//
//  Created by Дайняк Александр Николаевич on 01.05.2021.
//

import Foundation

import Domain
@testable import Coins_ph

/// Creating stub history model
extension History: StubProtocol {
    
    static func stub(withId id: Int = 1) -> Self {
        return History(
            id: String(id),
            entry: .incoming,
            balance: Amount(
                currency: .php,
                amount: 100
            ),
            sender: "somebody",
            recepient: "You"
        )
    }
}
