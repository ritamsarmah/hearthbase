//
//  CardSearchTableViewController.swift
//  HearthBase
//
//  Created by Ritam Sarmah on 9/29/16.
//  Copyright © 2016 Ritam Sarmah. All rights reserved.
//

import UIKit

class CardSearchTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let database = HearthstoneSearch()
    var cards = [Card]()
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let requestedCards = database.search(for: searchBar.text!) {
            cards = requestedCards
            tableView.reloadSections(IndexSet([0]), with: .automatic)
        } else {
            showAlert(for: .cardNotFound)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardTableViewCell

        let card = cards[indexPath.row]
        let imageData = database.getCardImageData(for: card.id)
        cell.cardName.text = card.name
        cell.cardImageView.image = UIImage(data: imageData!)
        cell.cardType.text = "Type: " + card.type.capitalized
        cell.cardRarity.text = "Rarity: " + card.rarity.capitalized
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Alerts
    
    enum AlertType {
        case cardNotFound
    }
    
    private func showAlert(for type: AlertType) {
        var alert: UIAlertController
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        switch type {
        case .cardNotFound:
            alert = UIAlertController(title: "Unable to find card!", message: nil, preferredStyle: .alert)
            alert.addAction(dismissAction)
        }
        
        present(alert, animated: true, completion: nil)
    }

}
