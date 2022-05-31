//
//  WalletRepositoryMock.swift
//  Coins.phTests
//
//  Created by Дайняк Александр Николаевич on 01.05.2021.
//

import RxSwift
import Domain
@testable import Coins_ph

class WalletRepositoryMock: WalletRepository {
    
    //MARK: - getWallets
    
    var getWalletsReturnValue: Single<[Wallet]>!
    func getWallets() -> Single<[Wallet]> {
        getWalletsReturnValue
    }

}
