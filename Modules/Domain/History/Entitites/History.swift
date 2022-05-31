//
//  History.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Foundation


public struct History: Equatable {
    public let id: String
    public let entry: Entry
    public let balance: Amount
    public let sender: String
    public let recepient: String
    
    public init(
        id: String,
        entry: Entry,
        balance: Amount,
        sender: String,
        recepient: String
    ) {
        self.id = id
        self.entry = entry
        self.balance = balance
        self.sender = sender
        self.recepient = recepient
    }
}
