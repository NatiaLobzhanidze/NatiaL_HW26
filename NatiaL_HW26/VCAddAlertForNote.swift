//
//  VCCoreDataExt.swift
//  NatiaL_HW26
//
//  Created by Natia's Mac on 27.08.22.
//
import Foundation
import UIKit
import CoreData

extension ViewController {
    
    func addAlertToButton(for create: Bool, updateValue: String? ) {
    
        let alert = UIAlertController(title: "Add", message: "New Note", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
                                           
            guard let textField = alert.textFields?.first, let newNote = textField.text else { return }
            if create {
                self.coreDataManager.create(newNote: newNote, toEntity: "Note", array: &strNotes)
                
            } else {
                guard let updateValue = updateValue else { return }
                self.coreDataManager.updateValueOf(objectName: updateValue, by: newNote)
                if let e = strNotes.firstIndex(of: updateValue) {
                    strNotes[e] = newNote
                }
                self.tableView.reloadData()
            }
            
            self.tableView.reloadData()
          }
          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
          alert.addTextField()
          alert.addAction(saveAction)
          alert.addAction(cancelAction)
          present(alert, animated: true)
        }
}

