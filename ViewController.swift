//
//  ViewController.swift
//  EmailListV5
//
//  Created by user on 4/2/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

struct cellData {
    let label : String
    let text : String
    
}

class TableViewController: UITableViewController, UISearchBarDelegate {

    
    var arrayOfCellData = [cellData(label: "Hello", text: "Where they at tho?"),
                           cellData(label: "Hello", text: "Where they at tho?"),
                           cellData(label: "Hello", text: "Where they at tho?")]
    
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        self.navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        searchBar.delegate = self
    }


    
    func setUpTableView() {
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = arrayOfCellData[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.label.text = item.label
        cell.textField.text = item.text
        return cell
    }
}

