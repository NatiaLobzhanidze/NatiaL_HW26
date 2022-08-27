//
//  ViewController.swift
//  NatiaL_HW26
//
//  Created by Natia's Mac on 26.08.22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes = [NSManagedObject]()
    
    var coreDataManager: CoreDataManager!
    
    var strNotes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataManager = CoreDataManager()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(class: TableViewCell.self)
        coreDataManager.getFetchedDatas { [weak self] results in
          
            self?.strNotes = results
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        self.coreDataManager.getFetchedDatas {[weak self] result in
            self?.strNotes = result
        }
    }
    
    @IBAction func addNewNote(_ sender: UIBarButtonItem) {
        addAlertToButton(for: true, updateValue: nil)
       
    }

}

