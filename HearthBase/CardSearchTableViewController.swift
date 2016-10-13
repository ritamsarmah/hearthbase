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
    
    private let database = HearthstoneSearch()
    private var cards = [Card]()
    private var imageCache = [String: Data]()
    
    struct Storyboard {
        static let ShowCardSegue = "Show Card Detail"
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        RecentSearches().add(search: searchBar.text!)
        imageCache.removeAll()
        DispatchQueue.global(qos: .userInitiated).async {
            if let requestedCards = self.database.search(for: searchBar.text!) {
                self.cards = requestedCards
                DispatchQueue.main.async {
                    self.tableView.reloadSections(IndexSet([0]), with: .automatic)
                    
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(for: .cardNotFound)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        imageCache.removeAll()
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
        
        // Reset cell
        cell.cardName.text = nil
        cell.cardImageView.image = nil
        
        let card = cards[indexPath.row]
        cell.cardName.text = card.name
        cell.cardId = card.id
        cell.imageLoadingIndicator.startAnimating()
        
        if let imageData = imageCache[card.id] {
            cell.cardImageView.image = UIImage(data: imageData)
            cell.imageLoadingIndicator.stopAnimating()
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = self.database.getCardImageData(for: card.id) {
                    DispatchQueue.main.async {
                        cell.cardImageView.image = UIImage(data: imageData)
                        cell.imageLoadingIndicator.stopAnimating()
                    }
                    self.imageCache[card.id] = imageData
                } else {
                    print(("Failed to load image data"))
                }
            }
        }
        cell.cardType.text = "Type: " + card.type.capitalized
        cell.cardRarity.text = "Rarity: " + card.rarity.capitalized
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowCardSegue {
            let nvc = segue.destination as? UINavigationController
            if let cardvc = nvc?.topViewController as? CardViewController {
                if let cardCell = sender as? CardTableViewCell {
                    cardvc.card = database.getCard(for: cardCell.cardId!)
                    let imageData = self.database.getCardImageData(for: cardCell.cardId!)
                    cardvc.normalImage = UIImage(data: imageData!)
                }
            }
        }
    }
    
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
            alert = UIAlertController(title: "No matches found!", message: nil, preferredStyle: .alert)
            alert.addAction(dismissAction)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}
