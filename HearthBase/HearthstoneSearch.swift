//
//  HearthstoneSearch.swift
//  HearthBase
//
//  Created by Ritam Sarmah on 9/11/16.
//  Copyright © 2016 Ritam Sarmah. All rights reserved.
//

import Foundation
import SwiftyJSON

class HearthstoneSearch {
    
    private let url = URL(string: "https://api.hearthstonejson.com/v1/13921/enUS/cards.collectible.json")
    private let cardImageUrl = "http://wow.zamimg.com/images/hearthstone/cards/enus/original/"
    
    // Returns card ID as String
    func search(for searchText: String) -> [Card]? {
        let json = getJson()
        var cards = [Card]() // More relevant matches are at the front
        var secondary = [Card]()
        
        for card in json.arrayValue {
            
            if card["type"].stringValue == "HERO" {
                continue
            }
            
            let name = card["name"].stringValue.lowercased()
            
            if name.contains(searchText.lowercased()) {
                let newCard = createCard(from: card)
                
                // Checks if searchText matches first word
                if name.hasPrefix(searchText.lowercased()) {
                    cards.append(newCard)
                } else {
                    secondary.append(newCard)
                }
            }
        }
        
        if cards.isEmpty && secondary.isEmpty {
            return nil
        } else {
            cards.append(contentsOf: secondary)
            return cards
        }
    }
    
    // Returns card based on card ID
    func getCard(for id: String) -> Card? {
        let json = getJson()
        for card in json.arrayValue {
            if card["id"].stringValue == id {
                return createCard(from: card)
            }
        }
        return nil
    }
    
    // Returns data for card image based on ID
    func getCardImageData(for id: String) -> Data? {
        let imageURL = URL(string: cardImageUrl + id + ".png")
        do {
            let data = try Data(contentsOf: imageURL!)
            return data
        } catch {
            print(error)
            return nil
        }
    }

    // MARK: Helper Functions
    private func getJson() -> JSON {
        let data = try! Data(contentsOf: url!)
        return JSON(data: data)
    }
    
    private func createCard(from data: JSON) -> Card {
        return Card(name: data["name"].stringValue,
                    id: data["id"].stringValue,
                    type: data["type"].stringValue,
                    text: data["text"].stringValue,
                    rarity: data["rarity"].stringValue,
                    flavor: data["flavor"].stringValue)
    }
    
}
