//
//  HistoryError.swift
//  Domain
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import Foundation

public enum HistoryError: String, Decodable {
    case throttled
    case failed = "Failed" // other errors
}
