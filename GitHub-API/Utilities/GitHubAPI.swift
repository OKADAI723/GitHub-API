//
//  GitHubAPI.swift
//  GitHub-API
//
//  Created by Yudai Fujioka on 2021/07/10.
//

import Foundation

enum APIError: Error {
    case getItems
}

final class GitHubAPI {
    static let shared = GitHubAPI()
    private init() {}
    
    var json :[[String: Any]] = []
    
    func searchRepository(query: String, completion: ((GitHubRepositoryModel?,Error?) -> Void)? = nil) {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(query)&sort=stars&per_page=30&page=1") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _error = error {
                completion?(nil,APIError.getItems)
                print("情報の取得に失敗" + _error.localizedDescription)
                return
            }
           
            if let _data = data {
                do {
                    let items = try JSONDecoder().decode(GitHubRepositoryModel.self, from: _data)
                    completion?(items, nil)
                    print("items:",items)
                } catch (let error) {
                    completion?(nil,error)
                    print(error)
                    print("情報の取得に失敗" + error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
