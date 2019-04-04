//
//  ViewController.swift
//  EmailListV5
//
//  Created by user on 4/2/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: ViewModel!
    
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
        
        viewModel = ViewModel(emails: [Email(subject: "Hello", isRead: false),
                                       Email(subject: "URGENT: Please advise on how to proceed", isRead: false),
                                       Email(subject: "Dwight from the office: Following up", isRead: false),
                                       Email(subject: "CONGRATULATIONS, YOU'VE WON!", isRead: false),
                                       Email(subject: "Gutiérrez: Following up", isRead: false),
                                       Email(subject: "MTV Presents: Top 10 worst Rappers of 2019 (So Far)", isRead: false),
                                       Email(subject: "Groupon", isRead: false),
                                       Email(subject: "Hello, Friend", isRead: false)])
        
        viewModel.observer = self
    }

    func setUpTableView() {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.emails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let email = viewModel.output.emails[indexPath.row]
        
        if email.isRead {
            cell.label.font = UIFont.italicSystemFont(ofSize: 12)
        }
        cell.label.text = email.subject
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.input.selectedEmail(at: indexPath.row)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.input.deleteEmail(at: indexPath.row)
        }
    }

}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.input.filter(searchController.searchBar.text!)
    }
}

extension TableViewController: ViewModelObserver {

    func filterUpdated() {
        tableView.reloadData()
    }
    
    func addedEmail(at index: Int) {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    func updatedEmail(at index: Int) {
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }

    func deletedEmail(at index: Int) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }

}
