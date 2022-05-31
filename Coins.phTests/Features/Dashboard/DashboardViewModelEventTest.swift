//
//  DashboardViewModelEventTest.swift
//  Coins.phTests
//
//  Created by Дайняк Александр Николаевич on 01.05.2021.
//

import Dashboard
import XCTest
import RxSwift
import RxTest
import RxCocoa
import Domain
import CarbonKit
@testable import Coins_ph

class DashboardViewModelEventTest: XCTestCase {
    
    private var walletUseCase: WalletUseCaseMock!
    private var historyUseCase: HistoryUseCaseMock!
    private var dashboardViewModel: DashboardViewModel!
    private var walletSubject: PublishSubject<[Wallet]>!
    private var historySubject: PublishSubject<[History]>!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    private var content = PublishRelay<[Section]>()
    private let actionRelay = PublishRelay<DashboardViewModelInput.Action>()
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        walletUseCase = WalletUseCaseMock()
        historyUseCase = HistoryUseCaseMock()
        dashboardViewModel = DashboardViewModelImpl(
            historyUseCase: historyUseCase,
            walletsUseCase: walletUseCase
        )
        walletSubject = PublishSubject<[Wallet]>()
        historySubject = PublishSubject<[History]>()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testIfNumberOfSkeletonCellsForEachSectionAtStart() {
        
        let input = DashboardViewModelInput(action: actionRelay.asObservable())
        let output = dashboardViewModel.bind(input: input)
        
        scheduler
            .createColdObservable([.next(10, [])])
            .bind(to: walletSubject)
            .disposed(by: disposeBag)
        
        output
            .content
            .drive(onNext: { content in
                
                XCTAssertEqual(content.first!.cells.count, 3)
                XCTAssertEqual(content[1].cells.count, 3)
            })
            .disposed(by: disposeBag)
        
        actionRelay.accept(.start)
    }
    
}
