//
//  ViewController.swift
//  EmailListV5
//
//  Created by user on 4/2/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

struct Email {
    let subject: String
    let body: String
    var isRead: Bool = false
}

class TableViewController: UITableViewController {
    
    var emails = [Email(subject: "Helen", body: "", isRead: false),
                  Email(subject: "Hello", body: "", isRead: false),
                  Email(subject: "Hello0", body: "", isRead: false),
                  Email(subject: "Hello1", body: "", isRead: false),
                  Email(subject: "Hello2", body: "", isRead: false),
                  Email(subject: "Hello3", body: "", isRead: false),
                  Email(subject: "Hello4", body: "", isRead: false),
                  Email(subject: "Hello, Asshole", body: "", isRead: false)]

    var filteredEmails = [Email]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by Subject"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        
        
    }

    func setUpTableView() {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredEmails.count
        }
        return emails.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("hey")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        var email: Email
        if isFiltering() {
            email = filteredEmails[indexPath.row]
        } else {
            email =  emails[indexPath.row]
        }
        
        if email.isRead {
            cell.label.font = UIFont.italicSystemFont(ofSize: 12)
        }
        cell.label.text = email.subject
        cell.textField.text = email.body
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        emails[indexPath.row].isRead.toggle()
        
    }
}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredEmails = emails.filter({( cellData : Email) -> Bool in
            return cellData.subject.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

