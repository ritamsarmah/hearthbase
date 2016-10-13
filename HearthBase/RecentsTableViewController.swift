//
//  RecentsTableViewController.swift
//  HearthBase
//
//  Created by Ritam Sarmah on 10/12/16.
//  Copyright © 2016 Ritam Sarmah. All rights reserved.
//

import UIKit

class RecentsTableViewController: UITableViewController {
    
    let database = HearthstoneSearch()
    
    struct Storyboard {
        static let ShowSearches = "Show Searches"
        static let RecentCardCell = "Recent Card"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecentSearches().searches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.RecentCardCell, for: indexPath)
        
        
        let recentCard = RecentSearches().searches[indexPath.row]
        cell.textLabel?.text = recentCard       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            RecentSearches().remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowSearches {
            
        }
    }

    @IBAction func clearAll(sender: UIBarButtonItem) {
        RecentSearches().searches.removeAll()
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
