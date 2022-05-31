//
//  HistoryRepositoryMock.swift
//  Coins.phTests
//
//  Created by Дайняк Александр Николаевич on 01.05.2021.
//

import RxSwift
import Domain
@testable import Coins_ph

class HistoryRepositoryMock: HistoryRepository {
    
    //MARK: - getHistory
    
    var getHistoryReturnValue: Single<[History]>!
    func getHistory(for page: Int) -> Single<[History]> {
        getHistoryReturnValue
    }
}
