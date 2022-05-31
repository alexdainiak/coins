//
//  Single+Mapping.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Moya
import RxSwift

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func performMapping<Value: Decodable, Error: Swift.Error & Decodable>(
        valueType: Value.Type,
        errorType: Error.Type
    ) -> Single<Value> {
        return flatMap { response in
            return .just(try response.performMapping(
                valueType: Value.self,
                errorType: Error.self)
            )
        }
    }
    
    func performMapping<Value, Error: Swift.Error>(
        valueMapping: @escaping Mapper<Value>,
        errorMapping: @escaping Mapper<Error>,
        mappingStrategy: @escaping MappingStrategy<Value, Error>
    ) -> Single<Value> {
        return flatMap { response -> Single<Value> in
            return .just(try response.performMapping(
                valueMapping: valueMapping,
                errorMapping: errorMapping,
                mappingStrategy: mappingStrategy)
            )
        }
    }
}
