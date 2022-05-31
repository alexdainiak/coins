//
//  Wallet.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Foundation

public struct Wallet: Equatable {
    public let id: String
    public let walletName: String
    public let balance: Amount
    
    public init(
        id: String,
        walletName: String,
        balance: Amount
    ) {
        self.id = id
        self.walletName = walletName
        self.balance = balance
    }
}
