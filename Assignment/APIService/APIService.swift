//
//  APIService.swift
//  Assignment
//
//  Created by Shreyak Godala on 12/08/21.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    
    func fetchRepos(text: String,page: Int = 1, completion: @escaping([Repository]) -> ()) {
        guard let url = "https://api.github.com/search/repositories?q=\(text)&&page=\(page)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            
            guard let data = data else {return}
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            DispatchQueue.main.async {
                do {
                    let repoResults = try decoder.decode(RepositoryList.self, from: data)
                    completion(repoResults.items)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
        
    }
    
    
    
    
    
}
