//
//  CoreDataHelper.swift
//  Assignment
//
//  Created by Shreyak Godala on 12/08/21.
//

import UIKit
import CoreData

struct LocalDataBaseHelper {
    
    static var getAllObjects: [Repository] {
        let defaultObject = Repository(id: 0, name: "", description: "", language: "", stargazersCount: 0, owner: nil,forksCount: nil,openIssues: nil)
          if let objects = UserDefaults.standard.value(forKey: "local_repos") as? Data {
             let decoder = JSONDecoder()
             if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Repository] {
                return objectsDecoded
             } else {
                return [defaultObject]
             }
          } else {
             return [defaultObject]
          }
       }
    
    
    static func saveRepo(object: Repository) {
          var allObjects = getAllObjects
          allObjects.append(object)
          let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(allObjects){
             UserDefaults.standard.set(encoded, forKey: "local_repos")
          }
     }
    
    
}
