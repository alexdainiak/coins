//
//  MappingStrategy.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Moya

public typealias MappingStrategy<Value, Error: Swift.Error> = (Moya.Response, Mapper<Value>, Mapper<Error>) throws -> Value

public enum MappingStrategyCombiner {}

public extension MappingStrategyCombiner {
    
    static func `default`<Value, Error: Swift.Error>() -> MappingStrategy<Value, Error> {
        
        return { response, valueMapper, errorMapper in
            
            let isSuccess = (try? response.filterSuccessfulStatusCodes()) != nil
            
            do {
                let value = try valueMapper(response)
                
                return value
            } catch {
                if isSuccess {
                    throw MoyaError.objectMapping(error, response)
                }
                
                do {
                    let error = try errorMapper(response)
                    throw error
                } catch {
                    if error is Error {
                        throw error
                    } else {
                        throw MoyaError.objectMapping(error, response)
                    }
                }
            }
        }
    }
    
    
    static func standard<Value, Error: Swift.Error>() -> MappingStrategy<Value, Error> {
        return { response, valueMapper, errorMapper in
            let json = try? JSONSerialization.jsonObject(
                with: response.data,
                options: .allowFragments
            ) as? [String: Any]
            
            let isSuccess = (try? response.filterSuccessfulStatusCodes()) != nil
            
            switch isSuccess {
            case true:
                do {
                    let mappedValue = try valueMapper(response)
                    return mappedValue
                } catch {
                        throw MoyaError.objectMapping(error, response)
                }
            case false:
                do {
                    let error = try errorMapper(response)
                    throw error
                } catch {
                    if error is Error {
                        throw error
                    } else {
                        throw MoyaError.objectMapping(error, response)
                    }
                }
            }
        }
    }
}
        
