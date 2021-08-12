//
//  Repository.swift
//  Assignment
//
//  Created by Shreyak Godala on 12/08/21.
//

import Foundation


struct RepositoryList: Codable {
    
    var items: [Repository]
}

struct Repository: Codable {

    let id: Int
    let name: String?
    let description: String?
    let language: String?
    let stargazersCount: Int?
    let owner: Owner?
    let forksCount: Int?
    let openIssues: Int?
    

}


struct Owner: Codable {
    let login: String?
    let avatarUrl: String?
}




