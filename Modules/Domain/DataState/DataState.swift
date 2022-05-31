//
//  DataState.swift
//  Dashboard
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import Foundation

/// States of wallets and history lists
public enum DataState<T: Equatable, E: Error & Equatable>: Equatable {
    case loading
    case success(T)
    case empty
    case error(E)
}
