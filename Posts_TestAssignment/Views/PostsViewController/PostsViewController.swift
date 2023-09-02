//
//  PostsViewController.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 30.08.2023.
//

import UIKit
import SnapKit

final class PostsViewController: UIViewController {
    private var list: [PostModel] = []
    private var router: Router
    private var viewModel: PostsViewModel!
    private var network = NetworkPostsService()
    private var openedTableCellList = Set<UUID>()
    private let maximumHeight: CGFloat = 42.0
    private var isFilterViewHidden = true
    
    private var mainStackView: UIStackView = {
       let stack = UIStackView()
        stack.spacing = 8.0
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    private var filterView: FilterView = {
        let view = FilterView()
        view.isHidden = true
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 100)
        return view
    }()
    
    private var postsTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        return button
    }()
    
    init(router: Router, viewModel: PostsViewModel) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "posts"
        setupLayout()
        bindOnViewModel()
        setupTableView()
        viewModel.fetchData()
        
        addButton = UIBarButtonItem(title: "Додати", style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func bindOnViewModel() {
        viewModel.onLoading = { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                postsTableView.refreshControl?.beginRefreshing()
            } else {
                postsTableView.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.onLoadSuccess = { [weak self] list in
            guard let self else { return }
            self.list = list
            postsTableView.reloadData()
        }
        
        viewModel.onFailure = { [weak self] failure in
            guard let self else { return }
            guard let failure else { return }
            let alert = UIAlertController(title: failure,
                                          message: nil,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .cancel))
            present(alert, animated: true)
        }
        
        filterView.onDateFilterButtonTapped = { [weak self] isDescending in
            guard let self else { return }
            if isDescending {
                self.viewModel.reloadFilterDataByTimestampDescending()
            } else {
                self.viewModel.reloadFilterDataByTimestampDescending()
            }
        }
        
        filterView.onLikeFilterButtonTapped = { [weak self] isDescending in
            guard let self else { return }
            if isDescending {
                self.viewModel.reloadFilterDataByLikesDescending()
            } else {
                self.viewModel.reloadFilterDataByLikesDescending()
            }
        }
        
        filterView.onClearFilterButtonTapped = { [weak self] in
            guard let self else { return }
            self.viewModel.clearFiltes()
        }
    }
    
    private func setupLayout() {
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
        
        mainStackView.addArrangedSubview(filterView)
        mainStackView.addArrangedSubview(postsTableView)
    }
    
    private func setupTableView() {
        postsTableView.separatorStyle = .none
        postsTableView.dataSource = self
        postsTableView.delegate = self
        postsTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: PostsTableViewCell.identifier)
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 42
        
        let controll = UIRefreshControl()
        controll.addTarget(self, action: #selector(onPostsLoading), for: .valueChanged)
        postsTableView.refreshControl = controll
    }
    
    @objc private func onPostsLoading() {
        viewModel.fetchData()
    }
    
    @objc private func addButtonTapped() {
        filterView.isHidden.toggle()
    }
    
}

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.identifier, for: indexPath) as! PostsTableViewCell
        
        let previewLabelSize = list.previewText.height(withConstrainedWidth: tableView.frame.width - 36, font: .systemFont(ofSize: 16, weight: .regular))
        
        let canBeExpanded = previewLabelSize >= maximumHeight
        let isExpanded = openedTableCellList.contains(list.id)
        
        cell.setup(list, canBeExpanded: canBeExpanded, isExpanded: isExpanded)
        
        cell.onButtonClick = { [weak self] in
            guard let self else { return }
            
            if self.openedTableCellList.contains(list.id) {
                self.openedTableCellList.remove(list.id)
            } else {
                self.openedTableCellList.insert(list.id)
            }
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let list = list[indexPath.row]
        
        let previewLabelSize = list.previewText.height(withConstrainedWidth: tableView.frame.width - 36, font: .systemFont(ofSize: 16, weight: .regular))
        
        let canBeExpanded = previewLabelSize >= maximumHeight
        let isExpanded = openedTableCellList.contains(list.id)
        
        let staticHeight: CGFloat = 8 + 8 + 8 + 8 + 8
        let titleHeight: CGFloat = 42
        let buttomHeight: CGFloat = 18
        
        if canBeExpanded {
            if isExpanded {
                return titleHeight + previewLabelSize + buttomHeight + staticHeight
            } else {
                return titleHeight + maximumHeight + buttomHeight + staticHeight
            }
        } else {
            return titleHeight + previewLabelSize + staticHeight
        }
    }
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
