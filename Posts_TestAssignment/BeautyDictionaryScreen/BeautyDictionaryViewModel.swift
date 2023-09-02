//
//  BeautyDictionaryViewModel.swift
//  Sisters Staging
//
//  Created by Developer on 03.08.2023.
//

import Foundation

class BeautyDictionaryViewModel {

    deinit {
        print("BeautyDictionaryViewModel deinited")
        coordinator?.didFinish()
    }
    
    var coordinator: BeautyDictionaryCoordinator?
    
    var onLoad: (([String: [BeautyDictionaryTableViewCellModel]], [String]) -> (Void))?
    let tableViewMockedData = BeautyDictionaryTableViewCellModel.mockedData
    let collectionViewMockedData = BeautyDictionaryCollectionViewCellModel.mockedData
    var filteredTableViewData: [BeautyDictionaryTableViewCellModel] = []

    var tags = Set<String>()
    var searchText = String()
    
    var sortedKeys: [String] = []
    
    func setUpData() {
        if tags.count > 0 {
            updateDataByTags()
        } else if searchText.isEmpty {
            let results = sortData(tableViewMockedData)
            onLoad?(results, sortedKeys)
        } else {
            updateDataBySearchText()
        }
    }
    
    func updateDataByTags() {
        if searchText.isEmpty {
            filteredTableViewData.removeAll()
            for tag in tags {
                filteredTableViewData = filteredTableViewData + fetchData(tag: tag)
            }
            let results = sortData(filteredTableViewData)
            onLoad?(results, sortedKeys)
        } else {
            filteredTableViewData.removeAll()
            for tag in tags {
                filteredTableViewData = filteredTableViewData + fetchData(tag: tag)
            }
            let results = sortData(filteredTableViewData)
            onLoad?(results, sortedKeys)
            updateDataBySearchText()
        }
    }
    
    func updateDataBySearchText() {
        if tags.count > 0 {
            filteredTableViewData = filterResultsFilteredTableViewData(searchText: searchText)
            let results = sortData(filteredTableViewData)
            onLoad?(results, sortedKeys)
        } else {
            filteredTableViewData = filterDataTableViewMockedData(searchText: searchText)
            let results = sortData(filteredTableViewData)
            onLoad?(results, sortedKeys)
        }
    }
    
    private func sortData(_ data: [BeautyDictionaryTableViewCellModel]) -> ([String: [BeautyDictionaryTableViewCellModel]]) {
        let sortedData = data.sorted { $0.title < $1.title }
        var sortedKeys: [String] = []
        
        var wordDictionary = [String: [BeautyDictionaryTableViewCellModel]]()
        for model in sortedData {
            let firstLetter = String(model.title.prefix(1))
            sortedKeys.append(firstLetter)
            
            self.sortedKeys = sortedKeys.reduce(into: []) { result, element in
                if !result.contains(element) {
                    result.append(element)
                }
            }
            
            if var modelsArray = wordDictionary[firstLetter] {
                modelsArray.append(model)
                wordDictionary[firstLetter] = modelsArray
            } else {
                wordDictionary[firstLetter] = [model]
            }
        }
        return wordDictionary
    }
    
    private func fetchData(tag: String) -> [BeautyDictionaryTableViewCellModel] {
        switch tag {
        case "hair":
            return BeautyDictionaryCollectionViewCellModel.skinTableViewMockedData
        case "face":
            return BeautyDictionaryCollectionViewCellModel.hairTableViewMockedData
        case "body":
            return BeautyDictionaryCollectionViewCellModel.cosmeticTableViewMockedData
        case "home":
            return BeautyDictionaryCollectionViewCellModel.homeTableViewMockedData
        default: return BeautyDictionaryTableViewCellModel.mockedData
        }
    }
    
    private func filterDataTableViewMockedData(searchText: String) -> [BeautyDictionaryTableViewCellModel] {
        let filteredArray = tableViewMockedData.filter { element in
            return element.title.lowercased().contains(searchText.lowercased())
        }
        return filteredArray
    }
    
    private func filterResultsFilteredTableViewData(searchText: String) -> [BeautyDictionaryTableViewCellModel] {
        let filteredArray = filteredTableViewData.filter { element in
            return element.title.lowercased().contains(searchText.lowercased())
        }
        return filteredArray
    }
}
