//
//  WalletUseCaseMock.swift
//  Coins.phTests
//
//  Created by Дайняк Александр Николаевич on 01.05.2021.
//
import RxSwift
import RxCocoa
import Domain
@testable import Coins_ph

class WalletUseCaseMock: WalletsUseCase {
    
    private let bag = DisposeBag()
    
    var getWalletReturnValue: Single<[Wallet]>!
    
    var result: BehaviorRelay<DataState<[Wallet], DomainError<WalletError>>> = .init(value: .loading)
    
    func reload() {
    }
}
