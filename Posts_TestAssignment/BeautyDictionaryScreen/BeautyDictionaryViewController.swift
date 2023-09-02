//
//  BeautyDictionaryViewController.swift
//  Sisters Staging
//
//  Created by Developer on 03.08.2023.
//

import UIKit

class BeautyDictionaryViewController: UIViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    
    var viewModel: BeautyDictionaryViewModel
    let searchController = UISearchController(searchResultsController: nil)
    var collectionView: UICollectionView!
    let tableView = UITableView()
    var sectionTitles: [String] = []
    var tableViewMockedData: [String: [BeautyDictionaryTableViewCellModel]] = [:]
    var collectionViewMockedData: [BeautyDictionaryCollectionViewCellModel] = []
    var filteredData: [String: [BeautyDictionaryTableViewCellModel]] = [:]
    var openedCollectionCellList = Set<UUID>()
    var openedTableCellList = Set<UUID>()
    private let maximumHeight: CGFloat = 68.0
    
    init(viewModel: BeautyDictionaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Б'юті словник"
        view.backgroundColor = R.color.background()
        configureNavBar()
        configureSearchBar()
        collectionViewMockedData = viewModel.collectionViewMockedData
        viewModel.onLoad = { tableViewMockedData, sectionTitles in
            self.tableViewMockedData = tableViewMockedData
            self.filteredData = tableViewMockedData
            self.sectionTitles = sectionTitles
            self.tableView.reloadData()
        }
        viewModel.setUpData()
        configureCollectionView()
        configureTableView()
    }
    
    private func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationController?.navigationBar.tintColor = R.color.black()
        navigationController?.navigationBar.backgroundColor = .clear
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureSearchBar() {
        searchController.searchBar.placeholder = "Пошук"
        searchController.searchBar.backgroundColor = R.color.background()
        searchController.searchBar.delegate = self
    }
    
    @objc private func backButtonTapped() {
        viewModel.coordinator?.navidateToLoginedUserMenuScreen()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BeautyDictionaryCollectionViewCell.self, forCellWithReuseIdentifier: BeautyDictionaryCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(30)
        }
        collectionView.backgroundColor = .clear
    }
    
    private func setLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 12
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = CGSize(width: 16, height: 16)
        layout.footerReferenceSize = CGSize(width: 16, height: 16)
        return layout
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BeautyDictionaryTableViewCell.self, forCellReuseIdentifier: BeautyDictionaryTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64.0
        tableView.sectionIndexColor = R.color.mainGreen()
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        tableView.backgroundColor = R.color.white()
    }
}

extension BeautyDictionaryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        print(viewModel.searchText)
        if searchText.isEmpty {
            viewModel.setUpData()
        } else {
            viewModel.updateDataBySearchText()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension BeautyDictionaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewMockedData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeautyDictionaryCollectionViewCell.identifier, for: indexPath) as! BeautyDictionaryCollectionViewCell
        let model = collectionViewMockedData[indexPath.row]
    
        let isActive = openedCollectionCellList.contains(model.id)
        cell.setupModel(BeautyDictionaryCollectionViewCellModel.mockedData[indexPath.row], isActive: isActive)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeautyDictionaryCollectionViewCell.identifier, for: indexPath) as! BeautyDictionaryCollectionViewCell
        let model = collectionViewMockedData[indexPath.row]
        
        if viewModel.tags.contains(model.tag) {
            viewModel.tags.remove(model.tag)
        } else {
            viewModel.tags.insert(model.tag)
        }
        
        if viewModel.tags.count > 0 {
            viewModel.updateDataByTags()
        } else {
            viewModel.setUpData()
        }
        
        let isActive = openedCollectionCellList.contains(model.id)
        cell.setupModel(BeautyDictionaryCollectionViewCellModel.mockedData[indexPath.row], isActive: isActive)
        
        if self.openedCollectionCellList.contains(model.id) {
            self.openedCollectionCellList.remove(model.id)
        } else {
            self.openedCollectionCellList.insert(model.id)
        }
        
        collectionView.reloadItems(at: [indexPath])
    }
}

extension BeautyDictionaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeautyDictionaryTableViewCell.identifier, for: indexPath) as! BeautyDictionaryTableViewCell
        let sectionTitle = sectionTitles[indexPath.section]
        guard let model = filteredData[sectionTitle]?[indexPath.row] else {
            return UITableViewCell()
        }
        
//        let subtitleSize = model.subtitle.size(font: UIFont.systemFont(ofSize: 14), width: tableView.frame.width)
        let subtitleSize = model.subtitle.height(withConstrainedWidth: tableView.frame.width - 36, font: UIFont.systemFont(ofSize: 16))
        let canBeExpanded = subtitleSize >= maximumHeight
        let isExpanded = openedTableCellList.contains(model.id)
        
        cell.setupModel(model, canBeExpanded: canBeExpanded, isExpanded: isExpanded)
        
        cell.onButtonClick = { [weak self] in
            guard let self else { return }
            
            if self.openedTableCellList.contains(model.id) {
                self.openedTableCellList.remove(model.id)
            } else {
                self.openedTableCellList.insert(model.id)
            }
            
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionTitle = sectionTitles[indexPath.section]
        guard let model = tableViewMockedData[sectionTitle]?[indexPath.row] else {
            return 0
        }
        
        let isExpanded = openedTableCellList.contains(model.id)
        let subtitleSize = model.subtitle.height(withConstrainedWidth: tableView.frame.width - 36, font: UIFont.systemFont(ofSize: 16))
        let canBeExpanded = subtitleSize >= maximumHeight
        let staticHeight: CGFloat = 10 + 10 + 4 + 12
        let titleHeight: CGFloat = 22
        let buttomHeight: CGFloat = 24
        
        if canBeExpanded {
            if isExpanded {
                return titleHeight + subtitleSize + buttomHeight + staticHeight
            } else {
                return titleHeight + maximumHeight + buttomHeight + staticHeight
            }
        } else {
            return titleHeight + subtitleSize + staticHeight
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return sectionTitles.firstIndex(of: title) ?? 0
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = sectionTitles[section]
        return filteredData[sectionTitle]?.count ?? 0
    }
}


