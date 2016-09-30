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
    func search(for card: String) -> [Card]? {
        let json = getJson()
        var cards = [Card]()
        for jsonCard in json.arrayValue {
            let cardName = jsonCard["name"].stringValue.components(separatedBy: " ")
            for word in cardName {
                if word.lowercased().hasPrefix(card.lowercased()) {
                    let newCard = Card(name: jsonCard["name"].stringValue,
                                       id: jsonCard["id"].stringValue,
                                       type: jsonCard["type"].stringValue,
                                       text: jsonCard["text"].stringValue,
                                       rarity: jsonCard["rarity"].stringValue)
                    cards.append(newCard)
                    continue
                }
            }
        }
        
        if cards.isEmpty {
            return nil
        } else {
            for card in cards {
                print(card.name)
            }
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
            let newCard = Card(name: card["name"].stringValue,
                               id: card["id"].stringValue,
                               type: card["type"].stringValue,
                               text: card["text"].stringValue,
                               rarity: card["rarity"].stringValue)
            cards.append(newCard)
        }
        return cards
    }
    
    // MARK: Helper Functions
    fileprivate func getJson() -> JSON {
        let data = try! Data(contentsOf: url!)
        return JSON(data: data)
    }
    
}
