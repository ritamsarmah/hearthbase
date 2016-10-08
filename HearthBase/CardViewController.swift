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
    
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var cardRarity: UILabel!
    
    @IBOutlet weak var normalCardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = normalImage {
            normalCardImageView.image = image
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        cardName.text = card?.name
        cardType.text = card?.type.capitalized
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
            cardRarity.textColor = UIColor.blue
        case "EPIC":
            cardRarity.textColor = UIColor.purple
        case "LEGENDARY":
            cardRarity.textColor = UIColor.orange
        default:
            cardRarity.textColor = UIColor.black
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
