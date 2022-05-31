//
//  MoyaError + HierachyError.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import AppFoundation
import Moya

extension MoyaError: HierarchyError {    
    
    /// In order to implement this property at a lower level -
    /// it is necessary to sign `AFError` with the` ComposableError` protocol.
    /// Is this exactly what you need? :)
    public var parentHierarchyError: HierarchyError? {
        return self.asAFError as? HierarchyError
    }
    
    /// The error codes are based on the abbreviations for the MoyaError error types
    public var errorCode: String {
        let errorID: String
        switch self {
        case .imageMapping:
            errorID = "IM"
        case .jsonMapping:
            errorID = "JM"
        case .stringMapping:
            errorID = "SM"
        case .objectMapping:
            errorID = "OM"
        case .encodableMapping:
            errorID = "EM"
        case .statusCode:
            errorID = "SC"
        case .underlying:
            errorID = "U"
        case .requestMapping:
            errorID = "RM"
        case .parameterEncoding:
            errorID = "PM"
        }
        
        return "Moya-" + errorID
    }
}
