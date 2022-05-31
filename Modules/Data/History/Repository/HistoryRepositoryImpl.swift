//
//  HistoryRepositoryImpl.swift
//  Data
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import Domain
import RxSwift
import Network
import AppFoundation

final public class HistoryRepositoryImpl: HistoryRepository {
    
    // MARK: - Private properties
    
    private let provider: HistoryProvider
    private let errorTranslator: AnyErrorTranslator<ApiErrorModel, DomainError<HistoryError>>
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    
    // MARK: - Init
    
    public init(
        provider: HistoryProvider,
        errorTranslator: AnyErrorTranslator<ApiErrorModel, DomainError<HistoryError>>
    ) {
        self.provider = provider
        self.errorTranslator = errorTranslator
    }
    
    // MARK: - Public methods
    
    public func getHistory(for page: Int) -> Single<[History]> {
        
        provider
            .rx
            .request(.getHistory)
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .performMapping(
                valueType: HistoriesDto.self,
                errorType: ApiErrorModel.self
            )
            .map { $0.asDomain() }
            .handleError(using: errorTranslator)
            .subscribeOn(scheduler)
    }
}
