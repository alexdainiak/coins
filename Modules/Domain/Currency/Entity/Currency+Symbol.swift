//
//  Currency+Symbol.swift
//  Domain
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

public extension Currency {
    var symbol: String {
        switch self {
            case .php:
                return "₱"
            case .usd:
                return "$"
            case .eur:
                return "€"
            case .other(let code):
                return getSymbol(by: code)
        }
    }
    
    func getSymbol(by code: String) -> String {
        guard let identifier = Locale.availableIdentifiers
                .first(where: { Locale(identifier: $0).currencyCode == code })
        else { return code }
        
        return Locale(identifier: identifier).currencySymbol ?? code
    }
}
