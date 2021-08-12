//
//  ViewController.swift
//  Assignment
//
//  Created by Shreyak Godala on 12/08/21.
//

import UIKit

class SearchController: UITableViewController {

    private let cellId = "homeCellId"
    var timer: Timer?
    var repos: [Repository] = []
    var currentPage : Int = 1
    var isLoadingList : Bool = false
    var searchText = "HelloWorld"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupSearchController()
        initialRepoFetch()
        
    }
    
    
    func setupTableView() {
        tableView.register(RepositoryTableCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    func setupSearchController() {
        
        self.definesPresentationContext = true
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        
    }
    
    func initialRepoFetch() {
        APIService.shared.fetchRepos(text: searchText) { result in
            DispatchQueue.main.async {
                self.repos = result
                self.tableView.reloadData()
            }
            
        }
    }
    
    func loadMoreReposForList(){
        currentPage += 1
        APIService.shared.fetchRepos(text: searchText, page: currentPage) { result in
            DispatchQueue.main.async {
                self.repos += result
                self.tableView.reloadData()
            }
            
         }

       }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepositoryTableCell
        cell.repository = repos[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == repos.count - 1 && !isLoadingList {
            self.isLoadingList = true
            loadMoreReposForList()
            self.isLoadingList = false
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repos[indexPath.row]
        let repoDetailVC = RepoDetailController(repository: repo)
        self.navigationController?.pushViewController(repoDetailVC, animated: true)
    }

}


extension SearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { timer in
            APIService.shared.fetchRepos(text: searchText) { result in
                DispatchQueue.main.async {
                    self.repos = result
                    self.tableView.reloadData()
                }
                
            }

        })
    }
        
    
}

