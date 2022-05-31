//
//  AmockTarget.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Moya

public protocol AmockTarget: BasicTarget {
}

/// Concrete Target of Amock service
public extension AmockTarget {
    
    var baseURL: URL {
        var urlComponents = URLComponents(string: "http://www.amock.io/api/dainiak/")!

        return urlComponents.url!
    }
    
    var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        return nil
    }
    
}
