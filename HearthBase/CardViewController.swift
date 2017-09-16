//
//  CardViewController.swift
//  HearthBase
//
//  Created by Ritam Sarmah on 10/3/16.
//  Copyright © 2016 Ritam Sarmah. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    var card: Card? {
        didSet {
            updateUI()
        }
    }
    var cardId: String?
    var cardImage: UIImage?
    let database = HearthstoneSearch()
    
    @IBOutlet weak var cardFlavor: UILabel!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var cardRarity: UILabel!
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoView.layer.cornerRadius = 6
        infoView.layer.borderWidth = 1
        infoView.layer.borderColor = UIColor(red:0.84, green:0.76, blue:0.56, alpha:1.0).cgColor
        infoView.clipsToBounds = true
        cardFlavor.numberOfLines = 0
        self.cardFlavor.text = ""
        self.cardName.text = ""
        self.cardType.text = ""
        self.cardRarity.text = ""
        
        if let cardImage = cardImage {
            cardImageView.image = cardImage
        }
        
        database.getCard(withId: cardId!) { (card, error) in
            if card == nil {
                print("data no card")
            }
            self.card = card
        }
        
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            if let card = self.card {
                print(card.name)
                self.cardFlavor.text = card.text
                self.cardName.text = card.name
                self.cardType.text = card.type
                self.setRarityLabel(rarity: card.rarity)
                self.cardImage = UIImage(data: self.database.getImageData(for: card)!)
                self.cardImageView.image = self.cardImage
            }
        }
        print("Hello world!")
    }
    
    
    private func setRarityLabel(rarity: String) {
        cardRarity.text = rarity
        
        switch rarity.capitalized {
        case "Free", "Common":
            cardRarity.textColor = UIColor.darkGray
        case "Rare":
            cardRarity.textColor = UIColor(red:0.10, green:0.26, blue:0.77, alpha:1.0)
        case "Epic":
            cardRarity.textColor = UIColor(red:0.70, green:0.00, blue:0.99, alpha:1.0)
        case "Legendary":
            cardRarity.textColor = UIColor(red:0.99, green:0.50, blue:0.11, alpha:1.0)
        default:
            cardRarity.textColor = UIColor.black
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
