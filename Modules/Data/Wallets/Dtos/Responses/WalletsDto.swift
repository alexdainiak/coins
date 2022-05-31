//
//  WalletDto.swift
//  Data
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Domain

public struct WalletsDto: Decodable {
    let wallets: [WalletDto]
}

public struct WalletDto: Decodable {
    let id: String
    let walletName: String
    let balance: String
    
    enum CodingKeys: String, CodingKey {
        case walletName = "wallet_name"
        case id, balance
    }
}

extension WalletDto {
    
    public func asDomain() -> Wallet {
        
        return Wallet(
            id: id,
            walletName: walletName,
            balance: Amount(
                currency: Currency(rawValue: walletName) ?? .other(code: walletName),
                amount: Decimal(string: balance)
            )
        )
    }
}

extension WalletsDto {
    public func asDomain() -> [Wallet] {
        
        return wallets.compactMap { $0.asDomain() }
    }
}
