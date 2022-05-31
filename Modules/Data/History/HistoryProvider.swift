//
//  HistoryProvider.swift
//  Data
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Foundation
import Moya

public class HistoryProvider: MoyaProvider<HistoryTarget> {
    
    public required init() {
        super.init(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    }
}
