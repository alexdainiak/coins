//
//  Currency.swift
//  Domain
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Foundation

public enum Currency: Equatable, Hashable {
    
    case usd
    case eur
    case php
    case other(code: String)
    
    public init?(rawValue: String?) {
        switch rawValue {
            case .none:
                return nil
                
            case let .some(value):
                switch value.uppercased() {
                    case "EUR":
                        self = .eur
                    case "PHP":
                        self = .php
                    case "USD":
                        self = .usd
                    default:
                        self = .other(code: value)
                }
        }
    }
    
    public var rawValue: String {
        switch self {
            case .eur:
                return "EUR"
            case .php:
                return "PHP"
            case .usd:
                return "USD"
            case .other(let code):
                return code
        }
    }
}
