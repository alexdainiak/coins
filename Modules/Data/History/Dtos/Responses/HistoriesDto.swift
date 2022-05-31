//
//  HistoryDto.swift
//  Data
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Domain

public struct HistoriesDto: Decodable {
    let histories: [HistoryDto]
}

public struct HistoryDto: Decodable {
    let id: String
    let entry: String
    let amount: String
    let currency: String
    let sender: String
    let recipient: String
}

extension HistoryDto {
    
    public func asDomain() -> History {
        
        return History(
            id: id,
            entry: Entry(rawValue: entry) ?? .undefined,
            balance: Amount(
                currency: Currency(rawValue: currency) ?? .other(code: currency),
                amount: Decimal(string: amount)
            ),
            sender: sender,
            recepient: recipient
        )
    }
}

extension HistoriesDto {
    public func asDomain() -> [History] {
        
        return histories.compactMap { $0.asDomain() }
    }
}
