//
//  IdViewController.swift
//  GitHub-API
//
//  Created by Yudai Fujioka on 2021/07/11.
//

import UIKit

final class IdViewController: UIViewController {

 
    var id: Int?
    
    @IBOutlet private weak var idLabel: UILabel! {
        didSet {
            idLabel.text = id?.description
        }
    }
    
}
