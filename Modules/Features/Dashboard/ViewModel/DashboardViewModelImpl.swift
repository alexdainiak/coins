//
//  DashboardViewModelImpl.swift
//  Dashboard
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import CarbonKit
import Domain
import RxSwift
import RxCocoa
import UIComponents

final public class DashboardViewModelImpl: DashboardModuleInput & DashboardModuleOutput {
    
    // MARK: Public properties
    
    public var title: String?
    
    // MARK: - Private properties
    
    private enum Consts {
        static let walletTitle = "My Wallets"
        static let historyTitle = "History"
        static let title = "Coins.ph"
    }
    
    private enum ItemId: String {
        case skeleton
        case headerHistory
        case headerWallet
    }
    
    public enum SectionId: String {
        case walletSkeleton
        case walletEmpty
        case wallets
        case history
        case historyEmpty
        case historySkeleton
        case walletsError
        case historyError
        
    }
    
    private var skeletonWallets: Section {
        Section(
            id: SectionId.walletSkeleton,
            header: self.headerWallets,
            cells: [
                CellNode(SkeletonItem(id: ItemId.skeleton)),
                CellNode(SkeletonItem(id: ItemId.skeleton)),
                CellNode(SkeletonItem(id: ItemId.skeleton))
            ])
    }
    
    private var emptyWallets: Section {
        Section(
            id: SectionId.walletEmpty,
            header: self.headerWallets,
            cells: [
                CellNode(EmptyDataItem.forWallets)
            ])
    }
    
    private var emptyHistory: Section {
        Section(
            id: SectionId.walletEmpty,
            header: self.headerHistory,
            cells: [
                CellNode(EmptyDataItem.forHistory)
            ])
    }
    
    private var skeletonHistory: Section {
        Section(
            id: SectionId.historySkeleton,
            header: self.headerHistory,
            cells: [
                CellNode(SkeletonItem(id: ItemId.skeleton)),
                CellNode(SkeletonItem(id: ItemId.skeleton)),
                CellNode(SkeletonItem(id: ItemId.skeleton))
            ])
    }
    
    private var headerHistory: ViewNode {
        ViewNode(HeaderItem(
            id: ItemId.headerHistory,
            title: Consts.historyTitle
        ))
    }
    
    private var headerWallets: ViewNode {
        ViewNode(HeaderItem(
            id: ItemId.headerWallet,
            title: Consts.walletTitle
        ))
    }
    
    private let bag = DisposeBag()
    private let content = PublishRelay<[Section]>()
    private let wallets = BehaviorRelay<Section>(value: Section(id: UUID()))
    private let history = BehaviorRelay<Section>(value: Section(id: UUID()))
    
    // MARK: - Initializers
    
    private var historyUseCase: HistoryUseCase
    private var walletsUseCase: WalletsUseCase
    
    // MARK: - Init
    
    public init(
        historyUseCase: HistoryUseCase,
        walletsUseCase: WalletsUseCase
    ) {
        
        self.historyUseCase = historyUseCase
        self.walletsUseCase = walletsUseCase
        
        historyUseCase.reload()
        walletsUseCase.reload()
    }
}

// MARK: - DashboardViewModelImpl extension

extension DashboardViewModelImpl: DashboardViewModel {
    
    public func bind(input: DashboardViewModelInput) -> DashboardViewModelOutput {
        
        walletsUseCase
            .result
            .subscribe(onNext: { [weak self, content, wallets, history] dataState in
                guard let self = self else { return }
                
                var sections: [Section] = []
                
                switch dataState {
                
                case .loading:
                    wallets.accept(self.skeletonWallets)
                    content.accept([self.skeletonWallets, history.value])
                    
                case .error(let error):
                    let errorSection = self.errorWallets(message: "reason: \(error.errorCode), message: \(error.message)")
                    wallets.accept(errorSection)
                    content.accept([errorSection, history.value])
                    
                case .success(let walletItems):
                    let rowItems = walletItems.map { wallet -> CellNode in
                        let rowItem = RowItem(
                            title: wallet.walletName,
                            balance: wallet.balance.titleWithoutSymbol
                        )
                        
                        return CellNode(rowItem)
                    }
                    
                    let walletSection = Section(
                        id: SectionId.wallets,
                        header: self.headerWallets,
                        cells: rowItems
                    )
                    
                    wallets.accept(walletSection)
                    content.accept([walletSection, history.value])
                    
                case .empty:
                    wallets.accept(self.emptyWallets)
                    content.accept([self.emptyWallets, history.value])
                }
            })
            .disposed(by: bag)
        
        historyUseCase
            .result
            .subscribe(onNext: { [weak self, content, wallets, history] dataState in
                guard let self = self else { return }
                
                switch dataState {
                
                case .loading:
                    history.accept(self.skeletonHistory)
                    content.accept([wallets.value, self.skeletonHistory])
                    
                    
                case .error(let error):
                    let errorSection = self.errorHistory(message: "reason: \(error.errorCode), message: \(error.message)")
                    history.accept(errorSection)
                    content.accept([wallets.value, errorSection])
                    
                case .success(let historyItems):
                    let rowItems = historyItems.map { element -> CellNode in
                        let rowItem = RowItem(
                            title: "\(element.recepient) \(element.entry) \(element.sender)",
                            balance: element.balance.title
                        )
                        
                        return CellNode(rowItem)
                    }
                    
                    let historySection = Section(
                        id: SectionId.history,
                        header: self.headerHistory,
                        cells: rowItems
                    )
                    
                    history.accept(historySection)
                    content.accept([wallets.value, historySection])
                    
                case .empty:
                    history.accept(self.emptyHistory)
                    content.accept([wallets.value, self.emptyHistory])
                }
            })
            .disposed(by: bag)
        
        input
            .action
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] action in
                guard let self = self else { return }
                
                switch action.event.element {
                case .start:
                    self.fiilCellsWithEmpty()
                case .reload:
                    self.fiilCellsWithEmpty()
                    self.historyUseCase.reload()
                    self.walletsUseCase.reload()
                case .none:
                    break
                }
            }
            .disposed(by: bag)
        
        let output = DashboardViewModelOutput(
            title: Driver.just(title ?? Consts.title),
            content: content.asDriver(onErrorDriveWith: .empty())
        )
        
        return output
    }
    
    
    private func errorWallets(message: String) -> Section {
        Section(
            id: SectionId.walletsError,
            header: self.headerWallets,
            cells: [
                CellNode(EmptyDataItem.errorWallet(message: message))
            ])
    }
    
    private func errorHistory(message: String) -> Section {
        Section(
            id: SectionId.historyError,
            header: self.headerHistory,
            cells: [
                CellNode(EmptyDataItem.errorHistory(message: message))
            ])
    }
    
    private func fiilCellsWithEmpty() {
        self.wallets.accept(self.skeletonWallets)
        self.history.accept(self.skeletonHistory)
        self.content.accept([self.wallets.value, self.history.value])
    }
}
