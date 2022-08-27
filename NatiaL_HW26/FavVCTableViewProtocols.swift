//
//  FavVCTableViewProtocols.swift
//  NatiaL_HW26
//
//  Created by Natia's Mac on 27.08.22.
//

import Foundation
import UIKit
extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.deque(class: FavoritesTableViewCell.self, for: indexPath)
        cell.textLabel?.text = favoriteList[indexPath.row]
        
        return cell
    }
    
    
}
