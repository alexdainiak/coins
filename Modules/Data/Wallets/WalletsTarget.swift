//
//  WalletsTarget.swift
//  Data
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Domain
import Moya
import Network

public enum WalletsTarget {
    case getWallets
}

// MARK: - WalletsTarget extension

/// Target for wallets Service
extension WalletsTarget: AmockTarget {
    
    public var path: String {
        switch self {
        case .getWallets:
            let wallets = "wallets"
            let walletsEmpty = "wallets/empty"
            let walletsError = "wallets/error"
            let walletsErrorInternalError = "wallets/error500"
            
            return wallets
//            let number = Int.random(in: 0..<4)
//
//            switch number {
//            case 0:
//                return wallets
//            case 1:
//                return walletsEmpty
//            case 2:
//                return walletsError
//            case 3:
//                return walletsErrorInternalError
//            default:
//                return wallets
//            }
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getWallets:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .getWallets:
            return .requestPlain
        }
    }
}
