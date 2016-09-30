//
//  Card.swift
//  HearthBase
//
//  Created by Ritam Sarmah on 9/30/16.
//  Copyright © 2016 Ritam Sarmah. All rights reserved.
//

import Foundation

class Card {
    
    let name: String
    let id: String
    let type: String
    let text: String
    let rarity: String
    
    init(name: String, id: String, type: String, text: String, rarity: String) {
        self.name = name
        self.id = id
        self.type = type
        self.text = text
        self.rarity = rarity
    }
    
}