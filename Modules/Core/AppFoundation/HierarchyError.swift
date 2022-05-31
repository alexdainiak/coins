//
//  HierarchyError.swift
//  AppFoundation
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Foundation

public protocol HierarchyError: Swift.Error {
    
    /// The error which is a reason of a current error
    var parentHierarchyError: HierarchyError? { get }
    
    /// The unique name of the error domain, by which it can uniquely identify the type of error
    var domainError: String { get }
    
    /// Unique error code by which you can unambiguously identify the cause that caused it
    var errorCode: String { get }
}


public extension HierarchyError {
    
    func getParent<ErrorType: HierarchyError>(
            searching type: ErrorType.Type
        ) -> ErrorType? {
            if let error = self as? ErrorType {
                return error
            } else {
                return parentHierarchyError?.getParent(searching: type)
            }
        }
        
        var domainError: String {
           return String(reflecting: type(of: self))
                .filter { String($0) == String($0).uppercased() }
                .replacingOccurrences(of: "_.", with: "")
        }
        
        var path: String {
            let path = domainError + "-" + errorCode
            
            if let parentError = parentHierarchyError {
                return path + " | " + parentError.path
            } else {
                return path
            }
        }
}
