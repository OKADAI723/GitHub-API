//
//  SearchRepositoryViewController.swift
//  GitHub-API
//
//  Created by Yudai Fujioka on 2021/07/10.
//

import UIKit

final class SearchRepositoryViewController: UIViewController {
    
    //リポジトリ情報を格納する配列
    private var repositoryArray: [ItemsModel] = []
    //cellIdを定数化
    private let CELL_ID = "CELL_ID"
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
}

extension SearchRepositoryViewController: UISearchBarDelegate {
    //編集開始の処理
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        //キャンセルボタンを表示
        searchBar.showsCancelButton = true
        
        return true
    }
    
    //キャンセルボタンが押された時の処理
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //キャンセルボタンを非表示に
        searchBar.showsCancelButton = false
        //キーボードを下げる
        searchBar.resignFirstResponder()
    }
    
    //検索実行時の処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            return
        }
        //検索ワードが入っているなら検索をする
        guard !query.isEmpty else {
            return
        }
    
        GitHubAPI.shared.searchRepository(query: query) { (items, error) in
            if let _error = error {
                print("リポジトリの取得に失敗" + _error.localizedDescription)
                return
            }

            guard let _items = items else {
                print("失敗")
                return
            }
            
            self.repositoryArray = _items.items
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchRepositoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let idViewController = UIStoryboard.init(name: "Id", bundle: nil).instantiateInitialViewController() as? IdViewController else {
            fatalError()
        }
        
        idViewController.id = repositoryArray[indexPath.row].id
        self.present(idViewController, animated: true, completion: nil)
        
    }
}

extension SearchRepositoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID) else {
            fatalError()
        }
        
        let repository = repositoryArray[indexPath.row]
        
        cell.textLabel?.text = repository.name
//        cell.detailTextLabel?.text = repository.full_name
        
        return cell
    }
}
