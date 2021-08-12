//
//  RepoDetailController.swift
//  Assignment
//
//  Created by Shreyak Godala on 12/08/21.
//

import UIKit

class RepoDetailController: UITableViewController {
    
    var repo: Repository?
    private var repoCellId = "repoCellId"
    private var issuesCellId = "issuesCellId"
    private var prCellId = "prCellId"
    
    override func viewDidLoad() {
        setUpBarButtonItem()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if checkIfRepoExistsinDB() {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    init(repository: Repository) {
        super.init(style: .plain)
        self.repo = repository
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpTableView() {
        tableView.register(RepositoryTableCell.self, forCellReuseIdentifier: repoCellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: issuesCellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: prCellId)
        tableView.tableFooterView = UIView()
    }
    
    func setUpBarButtonItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRepoToDB))
    }
    
    @objc func addRepoToDB() {
        guard let repository = repo else {return}
        LocalDataBaseHelper.saveRepo(object: repository)
        NotificationCenter.default.post(name: Notification.Name("LocalNotificationIdentifier"), object: nil)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func checkIfRepoExistsinDB() -> Bool {
        for repository in LocalDataBaseHelper.getAllObjects {
            if repository.id == self.repo?.id {
                return true
            }
        }
        return false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: repoCellId, for: indexPath) as! RepositoryTableCell
            cell.repository = repo
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: issuesCellId)
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "Issues"
            cell.detailTextLabel?.text = "\(repo?.openIssues ?? 0)"
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: prCellId, for: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "Forks"
            cell.detailTextLabel?.text = "\(repo?.forksCount ?? 0)"
            cell.selectionStyle = .none
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
