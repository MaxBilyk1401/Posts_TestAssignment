//
//  SelectedPostViewController.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 03.09.2023.
//

import UIKit
import SnapKit

final class SelectedPostViewController: UIViewController {
    private var selectedPost: SelectedPostModel?
    private var router: Router
    private var viewModel: SelectedPostViewModel
    
    private var scrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.isScrollEnabled = true
        let controll = UIRefreshControl()
        controll.addTarget(self, action: #selector(onSelectedPostLoading), for: .valueChanged)
        scroll.refreshControl = controll
        return scroll
    }()
    
    private var wrapView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.numberOfLines = .min
        label.textAlignment = .center
        return label
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = .min
        return label
    }()
    
    private var postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var likeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    var likeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Images.heart.name)
        image.tintColor = UIColor(hexString: Colors.accent.name)
        return image
    }()
    
    var likeStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4.0
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    var calendarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Images.calendar.name)
        image.tintColor = UIColor(hexString: Colors.calendar.name)
        return image
    }()
    
    var dateStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4.0
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
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
        view.backgroundColor = .white
        setupLayout()
        bindOnViewModel()
        viewModel.fetchData()
        setupNavigationMultilineTitle()
    }
    
    private func bindOnViewModel() {
        viewModel.onLoading = { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                scrollView.refreshControl?.beginRefreshing()
            } else {
                scrollView.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.onLoadSuccess = { [weak self] list in
            guard let self else { return }
            self.selectedPost = list
            self.updateUI()
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
    
    private func updateUI() {
        if let post = selectedPost {
//            titleLabel.text = post.title
            postImage.setImage(with: post.postImage)
            textLabel.text = post.text
            likeLabel.text = "\(post.likesCount)"
            
            let formattedDate = post.timeshamp.getFormattedDate(format: "MM/dd/yyyy")
            dateLabel.text = "\(formattedDate)"
            
            let titleAttribute: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                .foregroundColor: UIColor.black
            ]
            
            navigationController?.navigationBar.titleTextAttributes = titleAttribute
            title = post.title
            
        }
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(wrapView)
        wrapView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        
        wrapView.addSubview(postImage)
        postImage.snp.makeConstraints { make in
            make.top.equalTo(wrapView.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width)
            make.width.equalTo(UIScreen.main.bounds.width * 0.5)
        }
        
        wrapView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(16.0)
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().inset(16.0)
        }
        
        wrapView.addSubview(likeStackView)
        likeStackView.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(16.0)
            make.leading.equalToSuperview().offset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
        likeStackView.addArrangedSubview(likeImage)
        likeStackView.addArrangedSubview(likeLabel)

        wrapView.addSubview(dateStackView)
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(16.0)
            make.leading.equalTo(likeStackView.snp.trailing).offset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
        dateStackView.addArrangedSubview(calendarImage)
        dateStackView.addArrangedSubview(dateLabel)
        
        
    }
    
    @objc private func onSelectedPostLoading() {
        viewModel.fetchData()
    }
}
