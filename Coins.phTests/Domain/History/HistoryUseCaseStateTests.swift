//
//  HistoryUseCaseStateTests.swift
//  Coins.phTests
//
//  Created by Дайняк Александр Николаевич on 01.05.2021.
//

import Domain
import RxSwift
import Quick
import Nimble
import RxNimble
import RxBlocking
@testable import Coins_ph

class HistoryUseCaseStateTests: QuickSpec {
    
    private var historyUseCase: HistoryUseCase!
    private var repository: HistoryRepositoryMock!
    private var disposeBag: DisposeBag!
    
    override func spec() {
        beforeEach {
            self.repository = HistoryRepositoryMock()
            self.historyUseCase = HistoryUseCaseImpl(repository: self.repository)
            self.disposeBag = DisposeBag()
        }
        describe("query history with state") {
            
            it("returns loading status before reload starts") {
                // Arrange
                self.repository.getHistoryReturnValue = .just([])
                
                let historyStateCount = self.historyUseCase.result
                
                // Act + Assert
                expect(historyStateCount).first.to(equal(.loading))
            }
            
            it("returns an empty array of history items") {
                // Arrange
                self.repository.getHistoryReturnValue = .just([])
                
                self.historyUseCase
                    .reload()
                
                let historyStateCount = self.historyUseCase.result
                
                // Act + Assert
                expect(historyStateCount).first.to(equal(.empty))
            }
            
            it("returns an array of three history items") {
                // Arrange
                let history = [History].stub(withCount: 3)
                self.repository.getHistoryReturnValue = .just(history)
                
                self.historyUseCase.reload()
                
                let historyStateCount = self.historyUseCase.result
                
                // Act + Assert
                if case .success(let wallets) = try historyStateCount.toBlocking().first() {
                    expect(wallets.count).to(equal(3))
                } else {
                    fail()
                }
                expect(historyStateCount).first.to(equal(.success(history)))
            }
            
            it("returns an error") {
                // Arrange
                
                let error = DomainError<HistoryError>.init(
                    code: HistoryError(rawValue: "throttled")!,
                    message: "foo",
                    parentHierarchyError: nil
                )
                
                self.repository.getHistoryReturnValue = .error(error)
                
                self.historyUseCase
                    .reload()
                
                let historyStateCount = self.historyUseCase.result
                
                // Act + Assert
                expect(historyStateCount).first.to(equal(.error(error)))
            }
        }
    }
}
