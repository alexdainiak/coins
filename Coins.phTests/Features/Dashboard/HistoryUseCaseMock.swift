//
//  HistoryUseCaseMock.swift
//  Coins.phTests
//
//  Created by Дайняк Александр Николаевич on 01.05.2021.
//

import RxSwift
import RxCocoa
import Domain
@testable import Coins_ph

class HistoryUseCaseMock: HistoryUseCase {
    private let bag = DisposeBag()
    
    var getHistoryReturnValue: Single<[History]>!
    
    var result: BehaviorRelay<DataState<[History], DomainError<HistoryError>>> = .init(value: .loading)
    
    func reload() {
    }
}
