//
//  Mapping.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Moya

/// Maps data from `Moya.Response` to model` T`
public typealias Mapper<T> = (Moya.Response) throws -> T

/// Namespace for all mapping closure factories.
/// - If necessary, add a new mapping method,
/// extend the namespace with new static functions / variables
public enum Mapping {}

public extension Mapping {
    
    /// Creates a mapping closure for Decodable models
    /// - Parameters:
    /// - type: model type
    /// - keyPath: path for mapping the model inside the JSON hierarchy
    /// - decoder: JSONDecoder
    /// - failsOnEmptyData: treat empty `Data` in` Response` as an error. Default is `false`
    static func decode<Value: Decodable>(
        _ type: Value.Type,
        keyPath: String? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        failsOnEmptyData: Bool = false
    ) -> Mapper<Value> {
        
        return { response in
            
            return try response.map(
                type,
                atKeyPath: keyPath,
                using: decoder,
                failsOnEmptyData: failsOnEmptyData
            )
        }
    }
}
