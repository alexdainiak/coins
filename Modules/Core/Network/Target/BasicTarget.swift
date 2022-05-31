//
//  BasicTarget.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Moya


public protocol BasicTarget: TargetType {
    var timeout: TimeInterval { get }
}

public extension BasicTarget {
    var timeout: TimeInterval { 30 }
}
