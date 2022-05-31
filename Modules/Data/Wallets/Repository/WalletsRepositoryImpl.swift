//
//  WalletsRepositoryImpl.swift
//  Data
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Domain
import RxSwift
import Network
import AppFoundation

final public class WalletsRepositoryImpl: WalletRepository {
    
    // MARK: - Private properties
    
    private let provider: WalletsProvider
    private let errorTranslator: AnyErrorTranslator<ApiErrorModel, DomainError<WalletError>>
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .default)

    // MARK: - Init
    
    public init(
        provider: WalletsProvider,
        errorTranslator: AnyErrorTranslator<ApiErrorModel, DomainError<WalletError>>
    ) {
        self.provider = provider
        self.errorTranslator = errorTranslator
    }
    
    // MARK: - Public methods
    
    public func getWallets() -> Single<[Wallet]> {
        provider
            .rx
            .request(.getWallets)
            .delay(.seconds(3), scheduler: MainScheduler.instance)
            .performMapping(
                valueType: WalletsDto.self,
                errorType: ApiErrorModel.self
            )
            .map { $0.asDomain() }
            .handleError(using: errorTranslator)
            .subscribeOn(scheduler)
    }
}
