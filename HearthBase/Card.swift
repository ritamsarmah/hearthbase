//
//  Card.swift
//  HearthBase
//
//  Created by Ritam Sarmah on 9/30/16.
//  Copyright © 2016 Ritam Sarmah. All rights reserved.
//

import Foundation
import SwiftyJSON

class Card {
    
    let name: String
    let id: String
    let cardSet: String
    let type: String
    let rarity: String
    let text: String
    let flavor: String
    let cost: Int
    let img: URL
    let artist: String
    
    let attack: Int?
    let health: Int?
    let faction: String?
    let race: String?
    let playerClass: String?
    
    init(with json: JSON) {
        self.name = json["name"].stringValue
        self.id = json["cardId"].stringValue
        self.cardSet = json["cardSet"].stringValue
        self.type = json ["type"].stringValue
        self.rarity = json ["rarity"].stringValue
        self.text = json ["text"].stringValue
        self.cost = json ["cost"].intValue
        self.img = URL(string: json["img"].stringValue)!
        self.artist = json["artist"].stringValue
        
        if let attack = json["attack"].int {
            self.attack = attack
        } else {
            self.attack = nil
        }
        
        if let health = json["health"].int {
            self.health = health
        } else {
            self.health = nil
        }
        
        if let faction = json["faction"].string {
            self.faction = faction
        } else {
            self.faction = nil
        }
        
        if let race = json["race"].string {
            self.race = race
        } else {
            self.race = nil
        }
        
        if let playerClass = json["playerClass"].string {
            self.playerClass = playerClass
        } else {
            self.playerClass = nil
        }
        
        let regex = try! NSRegularExpression(pattern: "<[^>]*>", options: [])
        let flavorText = json["flavor"].stringValue
        self.flavor = regex.stringByReplacingMatches(in: flavorText,
                                                     options: [],
                                                     range: NSMakeRange(0, flavorText.characters.count),
                                                     withTemplate: "")

    }
    
}
