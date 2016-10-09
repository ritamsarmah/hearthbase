//
//  CardViewController.swift
//  HearthBase
//
//  Created by Ritam Sarmah on 10/3/16.
//  Copyright © 2016 Ritam Sarmah. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    var card: Card?
    var normalImage: UIImage?
    
    @IBOutlet weak var cardFlavor: UILabel!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var cardRarity: UILabel!
    
    @IBOutlet weak var normalCardImageView: UIImageView!
    
    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        infoView.layer.cornerRadius = 6
        infoView.layer.borderWidth = 1
        infoView.layer.borderColor = UIColor(red:0.84, green:0.76, blue:0.56, alpha:1.0).cgColor
        infoView.clipsToBounds = true
        cardFlavor.numberOfLines = 0
        
        if let image = normalImage {
            normalCardImageView.image = image
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        cardName.text = card!.name
        cardType.text = card!.type.capitalized
        
        cardFlavor.text = card!.flavor
        setRarityLabel()
        
    }
    
    private func setRarityLabel() {
        guard let rarity = card?.rarity else {
            return
        }
        
        cardRarity.text = rarity.capitalized
        
        switch rarity {
        case "FREE", "COMMON":
            cardRarity.textColor = UIColor.darkGray
        case "RARE":
            cardRarity.textColor = UIColor(red:0.10, green:0.26, blue:0.77, alpha:1.0)
        case "EPIC":
            cardRarity.textColor = UIColor(red:0.70, green:0.00, blue:0.99, alpha:1.0)
        case "LEGENDARY":
            cardRarity.textColor = UIColor(red:0.99, green:0.50, blue:0.11, alpha:1.0)
        default:
            cardRarity.textColor = UIColor.black
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
