//
//  ViewController.swift
//  HearthBase
//
//  Created by Ritam Sarmah on 9/11/16.
//  Copyright © 2016 Ritam Sarmah. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cardImageView: UIImageView!
    var currentCardId: String? = nil
    
    let database = HearthstoneSearch()
    
    enum AlertType {
        case cardNotFound
        case cardImageNotFound
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        cardImageView.image = nil
        currentCardId = nil
        imageLoadingIndicator.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            if let id = self.database.search(for: searchBar.text!)
            {
                self.currentCardId = id
                guard let imageData = self.database.getCardImageData(withId: id) else {
                    self.showAlert(for: AlertType.cardImageNotFound)
                    return
                }
                
                DispatchQueue.main.async {
                    self.cardImageView.image = UIImage(data: imageData)
                    self.imageLoadingIndicator.stopAnimating()
                }
            } else {
                print("Card not found")
                DispatchQueue.main.async {
                    self.showAlert(for: .cardNotFound)
                    self.imageLoadingIndicator.stopAnimating()
                }
            }
        }
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
        case .cardImageNotFound:
            alert = UIAlertController(title: "Unable to load card image!", message: nil, preferredStyle: .alert)
            alert.addAction(dismissAction)
        }
        
        present(alert, animated: true, completion: nil)
    }
}

