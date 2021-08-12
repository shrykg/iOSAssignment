//
//  WatchListController.swift
//  Assignment
//
//  Created by Shreyak Godala on 12/08/21.
//

import UIKit

class WatchListController: UITableViewController {
    
    private let cellId = "cellId"
    var searchController = UISearchController(searchResultsController: nil)
    
    var filteredRepoList:[Repository] = []
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var repoList: [Repository] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.register(RepositoryTableCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        setupSearchController()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveRepo(_:)), name: Notification.Name("LocalNotificationIdentifier"), object: nil)
        repoList = LocalDataBaseHelper.getAllObjects
        
    }
    
    
    
    func setupSearchController() {
        
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Repositories"
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredRepoList.count
          }
        return repoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepositoryTableCell
          let repository: Repository
          if isFiltering {
            repository = filteredRepoList[indexPath.row]
          } else {
            repository = repoList.reversed()[indexPath.row]
          }
        cell.repository = repository
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredRepoList = repoList.filter { (repo: Repository) -> Bool in
            return (repo.name?.lowercased().contains(searchText.lowercased()))!
      }
      
      tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository: Repository
        if isFiltering {
          repository = filteredRepoList[indexPath.row]
        } else {
          repository = repoList[indexPath.row]
        }
        let repoDetailVC = RepoDetailController(repository: repository)
        self.navigationController?.pushViewController(repoDetailVC, animated: true)
    }

    @objc func onDidReceiveRepo(_ notification: Notification) {
        repoList = LocalDataBaseHelper.getAllObjects
    }
    
    
}


extension WatchListController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)

    }
    
    
}
