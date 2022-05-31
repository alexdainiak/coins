//
//  Money.swift
//  Domain
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Foundation

public struct Amount: Equatable {
    
    public let currency: Currency
    public let amount: Decimal?

    public init(
        currency: Currency,
        amount: Decimal?
    ) {
        self.currency = currency
        self.amount = amount
    }
}

public extension Amount {
    
   public var title: String {
        guard let amount = amount else {
            return ""
        }
        
        let formatter = NumberFormatter()
        formatter.roundingMode = .down
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 20
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        formatter.positiveSuffix = " " + currency.symbol
        
        return formatter.string(from: NSDecimalNumber(decimal: amount)) ?? ""
    }
    
    public var titleWithoutSymbol: String {
         guard let amount = amount else {
             return ""
         }
         
         let formatter = NumberFormatter()
         formatter.roundingMode = .down
         formatter.generatesDecimalNumbers = true
         formatter.minimumFractionDigits = 2
         formatter.maximumFractionDigits = 20
         formatter.groupingSeparator = ","
         formatter.numberStyle = .decimal
         
         return formatter.string(from: NSDecimalNumber(decimal: amount)) ?? ""
     }
}
