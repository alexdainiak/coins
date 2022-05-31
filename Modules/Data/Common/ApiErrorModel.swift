//
//  ApiErrorModel.swift
//  Data
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import AppFoundation

/// Standard error model
public struct ApiErrorModel: Decodable {
    
    // MARK: - Public properties
    
    /// Informative error code.
    /// * The business logic of the application can be attached to it.
    /// * Does not match HTTP request status codes
    public let code: String
    
    /// User-friendly error message /// * You can use it in Alert-e to notify the user about an error
    public let message: String
    
    /// External system code.
    /// The mobile backend can, in case of an unknown situation, return an external service error code in it
    public let externalCode: String?
    
    // The message returned by the backend in case of unknown situations or for the possibility of debugging.
    /// * Can be informative in particular for analysts.
    /// * May contain a technical description of the error of the external system that the mobile backend accessed
    /// * May contain information
    public let details: String?
    
    /// Идентификатор ошибки
    public let uuid: String?
    
    /// Service name, for example "communication-gateway"
    public let domain: String?
    
    // MARK: - Init
    
    public init(
        code: String,
        message: String,
        externalCode: String? = nil,
        details: String? = nil,
        uuid: String? = nil,
        domain: String? = nil
    ) {
        self.code = code
        self.message = message
        self.externalCode = externalCode
        self.details = details
        self.uuid = uuid
        self.domain = domain
    }
    
}

// MARK: - LocalizedError

extension ApiErrorModel: LocalizedError {
    public var errorDescription: String? {
        return message
    }
}

// MARK: - ComposableError

extension ApiErrorModel: HierarchyError {
    public var parentHierarchyError: HierarchyError? {
        return nil
    }
    
    public var errorCode: String {
        return "API-"+String(code)
    }
}
