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
    
    let url = URL(string: "https://api.hearthstonejson.com/v1/13921/enUS/cards.collectible.json")
    let cardImageUrl = "http://wow.zamimg.com/images/hearthstone/cards/enus/original/"
    
    // Returns card ID as String
    func search(for searchText: String) -> [Card]? {
        let json = getJson()
        var cards = [Card]() // More relevant matches are at the front
        var secondary = [Card]()
        
        for card in json.arrayValue {
            let name = card["name"].stringValue.lowercased()
            
            // Check for and returns exact match if found
            if name == searchText.lowercased() {
                return [createCard(from: card)]
            } else if name.contains(searchText.lowercased()) {
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
    
    // Returns info as JSON for card ID
    func getCard(for id: String) -> JSON {
        let json = getJson()
        for card in json.arrayValue {
            if card["id"].stringValue == id {
                return card
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
    
    func getAllCards() -> [Card] {
        let json = getJson()
        var cards = [Card]()
        for card in json.arrayValue {
            let newCard = createCard(from: card)
            cards.append(newCard)
        }
        return cards
    }
    
    // MARK: Helper Functions
    fileprivate func getJson() -> JSON {
        let data = try! Data(contentsOf: url!)
        return JSON(data: data)
    }
    
    fileprivate func createCard(from data: JSON) -> Card {
        return Card(name: data["name"].stringValue,
                    id: data["id"].stringValue,
                    type: data["type"].stringValue,
                    text: data["text"].stringValue,
                    rarity: data["rarity"].stringValue)
    }
    
}
