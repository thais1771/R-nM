//
//  SearchViewController.swift
//  R'nM
//
//  Created by Thais Rodríguez on 19/1/23.
//

import UIKit

class SearchViewController: UITableViewController {
    let tableViewCellIdentifier = "cellID"
    
    // MARK: Properties
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
        
        
    }
}
