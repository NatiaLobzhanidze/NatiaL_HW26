//
//  FavoriteListViewController.swift
//  NatiaL_HW26
//
//  Created by Natia's Mac on 27.08.22.
//

import UIKit
import CoreData

class FavoriteListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var favoriteList = [String]()
    var coreData: CoreDataManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        coreData = CoreDataManager()
        tableView.registerClass(class: FavoritesTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        coreData.getFavoriteNotes { [weak self] results in
            self?.favoriteList = results
            self?.tableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreData.getFavoriteNotes { [weak self] results in
            self?.favoriteList = results
            self?.tableView.reloadData()
        }
    }

}
