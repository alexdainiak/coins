//
//  HistoryRepository.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import RxSwift

public protocol HistoryRepository {
    func getHistory(for page: Int) -> Single<[History]>
}
