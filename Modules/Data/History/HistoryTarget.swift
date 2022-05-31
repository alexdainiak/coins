//
//  HistoryTarget.swift
//  Data
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Domain
import Moya
import Network

public enum HistoryTarget {
    case getHistory
}

// MARK: - HistoryTarget extension

extension HistoryTarget: AmockTarget {
    
    public var path: String {
        switch self {
        case .getHistory:
            let histories = "histories"
            let historiesEmpty = "histories/empty"
            let historiesError = "histories/error"
            let historiesLarge = "histories/large"
            
            let number = Int.random(in: 0..<4)
            
            switch number {
            case 0:
                return histories
            case 1:
                return historiesEmpty
            case 2:
                return historiesError
            case 3:
                return historiesLarge
            default:
                return histories
            }
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getHistory:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .getHistory:
            return .requestPlain
        }
    }
}
