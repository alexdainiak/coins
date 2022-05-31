//
//  DashboardViewController.swift
//  Dashboard
//
//  Created by Дайняк Александр Николаевич on 29.04.2021.
//

import UIKit
import RxSwift
import RxCocoa
import CarbonKit

final class DashboardViewController: UIViewController {
    
    // MARK: - Private properties
    
    private enum Consts {
        static let inset: CGFloat = 16
        
        static let backgroundColor = UIColor.white
    }
    
    private let actionRelay = PublishRelay<DashboardViewModelInput.Action>()

    private let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    private let bag = DisposeBag()
    
    private lazy var refreshControl = UIRefreshControl()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        tableView.estimatedRowHeight = 56
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Consts.backgroundColor
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
    // MARK: - Initializable
    
    private let viewModel: DashboardViewModel
    
    // MARK: - Init
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupSubviews()
        configureRenderer()
        addedRefreshControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        binding()
    }
    
    // MARK: - Private methods
    
    private func addedRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refresh() {
        actionRelay.accept(.reload)
    }
    
    private func configureRenderer() {
        renderer.target = tableView
    }
    
    private func setupSubviews() {
        
        let layoutGuide = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: layoutGuide.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: layoutGuide.leadingAnchor,
                constant: Consts.inset
            ),
            tableView.bottomAnchor.constraint(
                equalTo: layoutGuide.bottomAnchor,
                constant: -Consts.inset
            ),
            tableView.trailingAnchor.constraint(
                equalTo: layoutGuide.trailingAnchor,
                constant: -Consts.inset
            )
        ])
    }
    
}

private extension DashboardViewController {
    
    // MARK: - Private methods
    
    private func binding() {
        
        let input = DashboardViewModelInput(action: actionRelay.asObservable())
        
        let output = viewModel.bind(input: input)
        
        output
            .title
            .drive(rx.title)
            .disposed(by: bag)
        
        output
            .content
            .drive(onNext: { [weak self, renderer] content in
                self?.refreshControl.endRefreshing()
                renderer.render(content)
            })
            .disposed(by: bag)
        
        actionRelay.accept(.start)
    }
}
