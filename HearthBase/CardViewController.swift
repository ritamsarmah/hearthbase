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
    
    @IBOutlet weak var normalCardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = normalImage {
            normalCardImageView.image = image
        }
    }
    
    override func viewDidLayoutSubviews() {
        print("Card name: ", card?.name , "Card type: ", card?.type)
        cardName.text = card?.name
        cardType.text = card?.type.capitalized
        
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
