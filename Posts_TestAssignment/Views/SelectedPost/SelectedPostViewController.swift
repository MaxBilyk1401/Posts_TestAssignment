//
//  SelectedPostViewController.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 03.09.2023.
//

import UIKit

final class SelectedPostViewController: UIViewController {
    private var list: SelectedPostModel?
    private var router: Router
    private var viewModel: SelectedPostViewModel
    
    init(router: Router, viewModel: SelectedPostViewModel) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindOnViewModel()
        viewModel.fetchData()
    }
    
    private func bindOnViewModel() {
        viewModel.onLoading = { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
//                postsTableView.refreshControl?.beginRefreshing()
//            } else {
//                postsTableView.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.onLoadSuccess = { [weak self] list in
            guard let self else { return }
            self.list = list
            print(list)
//            postsTableView.reloadData()
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
    
}
