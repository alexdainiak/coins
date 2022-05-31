//
//  NerworkError.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import AppFoundation

public struct NetworkError: HierarchyError {
    
    // MARK: - Nested type

    public enum ServiceType: Int {
        case noInternet = 1
        case serverUnavailable = 2
        case cancelled = 3
        case badRequest = 4
        case dataMapping = 5
    }
    
    public let type: ServiceType
    public let data: Data?
    public var parentHierarchyError: HierarchyError?
    
    public var errorCode: String {
        return String(type.rawValue)
    }
    
    public init(type: ServiceType, parentError: HierarchyError?, data: Data?) {
        self.type = type
        self.parentHierarchyError = parentError
        self.data = data
    }
}
