//
//  InitialViewController.swift
//  GitHub-API
//
//  Created by Yudai Fujioka on 2021/07/10.
//

import UIKit

final class InitialViewController: UIViewController {

    @IBOutlet private weak var searchButton: UIButton! {
        didSet {
            searchButton.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
        }
    }
}

@objc private extension InitialViewController {
    
    //検索ボタンが押された時の処理
    func tappedSearchButton() {
        //リポジトリの検索画面のStoryboardからViewControllerをインスタンス化
        guard let searchRepositoryViewController = UIStoryboard.init(name: "SearchRepository", bundle: nil).instantiateInitialViewController() as? SearchRepositoryViewController else {
            fatalError()
        }
        
        //リポジトリの検索画面へ遷移
        self.navigationController?.pushViewController(searchRepositoryViewController, animated: true)
    }
}
