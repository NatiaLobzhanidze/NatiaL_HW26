//
//  TableViewDataSourc_delegate.swift
//  NatiaL_HW26
//
//  Created by Natia's Mac on 27.08.22.
//

import Foundation
import UIKit
import CoreData

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: TableViewCell.self, for: indexPath)
        cell.textlb?.text =  notes[indexPath.row].note

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            coreDataManager.deleteData(fromEntity: "Note", elementDescription: notes[indexPath.row].note!)
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addAlertToButton(for: false , updateValue: notes[indexPath.row])
        tableView.reloadData()
    }
}
