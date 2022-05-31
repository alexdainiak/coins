//
//  HistoryUseCaseImpl.swift
//  Domain
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import RxSwift
import RxCocoa

public class HistoryUseCaseImpl: HistoryUseCase {
    
    // MARK: - Public properties
    
    public var result: BehaviorRelay<DataState<[History], DomainError<HistoryError>>> = .init(value: .loading)
    
    // MARK: - Private properties
    
    private let bag = DisposeBag()
    
    // MARK: - Initializable
    
    private let repository: HistoryRepository
    
    // MARK: - Init
    
    public init(repository: HistoryRepository) {
        self.repository = repository
    }
    
    // MARK: - Public methods
    
    public func reload() {
        
        repository
            .getHistory(for: 0)
            .subscribe(
                onSuccess: { [result] history in
                    if !history.isEmpty {
                        result.accept(.success(history))
                    } else {
                        result.accept(.empty)
                    }
                },
                onError: { [result] error in
                    if let error = error as? DomainError<HistoryError> {
                        result.accept(.error(error))
                    }
                }
            )
            .disposed(by: bag)
    }
}
