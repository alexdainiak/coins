//
//  WalletsUseCaseStateTests.swift
//  Coins.phTests
//
//  Created by Дайняк Александр Николаевич on 01.05.2021.
//

import Domain
import XCTest
import RxSwift
import RxBlocking
@testable import Coins_ph

class WalletsUseCaseStateTests: XCTestCase {
    
    private var walletsUseCase: WalletsUseCase!
    private var repository: WalletRepositoryMock!
    private var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = WalletRepositoryMock()
        walletsUseCase = WalletsUseCaseImpl(repository: repository)
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testWalletsStatusBeforeReload() throws {
        // Arrange
        repository.getWalletsReturnValue = .just([])
        
        let walletsStateCount = walletsUseCase.result
        
        // Act + Assert
        XCTAssertEqual(try walletsStateCount.toBlocking().first(), .loading)
    }
    
    func testQueryStatusNoWallets() throws {
        // Arrange
        repository.getWalletsReturnValue = .just([])
        
        walletsUseCase
            .reload()
        
        let walletsStateCount = walletsUseCase.result
        
        if case .empty = try walletsStateCount.toBlocking().first() {
            XCTAssertTrue(true, "Array is empty")
        } else {
            XCTFail()
        }
        
        // Act + Assert
        XCTAssertEqual(try walletsStateCount.toBlocking().first(), .empty)
    }
    
    func testQueryStatusWithThreeWallets() throws {
        // Arrange
        let wallets = [Wallet].stub(withCount: 3)
        repository.getWalletsReturnValue = .just(wallets)
        
        walletsUseCase
            .reload()
        
        let walletsStateCount = walletsUseCase.result
        
        if case .success(let wallets) = try walletsStateCount.toBlocking().first() {
            XCTAssertEqual(wallets.count, 3)
        } else {
            XCTFail()
        }
        
        // Act + Assert
        XCTAssertEqual(try walletsStateCount
                        .toBlocking()
                        .first(), .success(wallets))
    }
    
    func testQueryWalletsStatusWithError() throws {
        // Arrange
        
        let error = DomainError<WalletError>.init(
            code: WalletError(rawValue: "throttled")!,
            message: "foo",
            parentHierarchyError: nil
        )
        
        repository.getWalletsReturnValue = .error(error)
        
        walletsUseCase
            .reload()
        
        let walletsStateCount = walletsUseCase.result
        
        // Act + Assert
        XCTAssertEqual(try walletsStateCount
                        .toBlocking()
                        .first(), .error(error))
    }
}
