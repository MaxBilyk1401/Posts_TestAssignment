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
    var openedTableCellList = Set<UUID>()
    private let maximumHeight: CGFloat = 36.0
    
    var postsTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
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
        print(list)
        setupTableView()
        bindOnViewModel()
        viewModel.fetchData()
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
            print(list)
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
    }
    
    private func setupLayout() {
        view.addSubview(postsTableView)
        postsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func setupTableView() {
        postsTableView.separatorStyle = .none
        postsTableView.dataSource = self
        postsTableView.delegate = self
        postsTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: PostsTableViewCell.identifier)
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 38.0
        
        let controll = UIRefreshControl()
        controll.addTarget(self, action: #selector(onPostsLoading), for: .valueChanged)
        postsTableView.refreshControl = controll
    }
    
    @objc private func onPostsLoading() {
        viewModel.fetchData()
    }
}

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.identifier, for: indexPath) as! PostsTableViewCell
        
        let previewLabelSize = list.previewText.height(withConstrainedWidth: tableView.frame.width - 32, font: .systemFont(ofSize: 16, weight: .regular))
        
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
        
        let previewLabelSize = list.previewText.height(withConstrainedWidth: tableView.frame.width - 32, font: .systemFont(ofSize: 16, weight: .regular))
        
        let canBeExpanded = previewLabelSize >= maximumHeight
        let isExpanded = openedTableCellList.contains(list.id)
        
        let staticHeight: CGFloat = 4 + 8 + 8 + 8 + 8
        let titleHeight: CGFloat = 48
        let buttomHeight: CGFloat =  24
        
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
