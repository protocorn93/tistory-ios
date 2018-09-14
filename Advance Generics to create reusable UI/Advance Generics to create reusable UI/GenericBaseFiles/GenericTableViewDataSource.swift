//
//  GenericTableViewDataSource.swift
//  Advance Generics to create reusable UI
//
//  Created by 이동건 on 14/09/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

final class GenericTableViewDataSource<V, T: Searchable>: NSObject, UITableViewDataSource where V: BaseTableViewCell<T> {
    
    typealias CellConfiguration = (V,T) -> V
    
    //MARK: Properties
    private var models: [T]
    private let configureCell: CellConfiguration
    private var searchResults: [T] = []
    private var isSearchActive: Bool = false
    
    //MARK: Life Cycle
    init(models: [T], configureCell: @escaping CellConfiguration) {
        self.models = models
        self.configureCell = configureCell
    }
    
    //MARK: DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? searchResults.count : models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: V = tableView.dequeueReusableCell(for: indexPath)
        let model = getModel(at: indexPath)
        return configureCell(cell, model)
    }
    
    private func getModel(at indexPath: IndexPath) -> T {
        return isSearchActive ? searchResults[indexPath.item] :  models[indexPath.item]
    }
    
    //MARK: External function for Searching
    func search(for query: String) {
        isSearchActive = !query.isEmpty
        searchResults = models.filter {
            let queryToFind = $0.query.range(of: query, options: NSString.CompareOptions.caseInsensitive)
            return (queryToFind != nil)
        }
    }
}
