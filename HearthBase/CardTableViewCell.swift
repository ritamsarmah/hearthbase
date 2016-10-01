//
//  CardTableViewCell.swift
//  HearthBase
//
//  Created by Ritam Sarmah on 9/29/16.
//  Copyright © 2016 Ritam Sarmah. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var cardRarity: UILabel!
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    
}
