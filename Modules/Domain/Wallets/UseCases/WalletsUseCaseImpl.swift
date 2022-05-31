//
//  WalletsUseCaseImpl.swift
//  Domain
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//
import RxSwift
import RxCocoa

public class WalletsUseCaseImpl: WalletsUseCase {
    
    // MARK: - Public properties
    
    public let result: BehaviorRelay<DataState<[Wallet], DomainError<WalletError>>> = .init(value: .loading)
    
    // MARK: - Private properties
    
    private let bag = DisposeBag()
    
    // MARK: - Initializable
    
    private let repository: WalletRepository
    
    // MARK: - Init
    
    public init(repository: WalletRepository) {
        self.repository = repository
    }
    
    // MARK: - Public methods
    
    public func reload() {
        
        repository
            .getWallets()
            .subscribe(
                onSuccess: { [result] wallets in
                    if !wallets.isEmpty {
                        result.accept(.success(wallets))
                    } else {
                        result.accept(.empty)
                    }
                },
                onError: { [result] error in
                    
                    if let error = error as? DomainError<WalletError> {
                        result.accept(.error(error))
                    }
                }
            )
            .disposed(by: bag)
    }
}
