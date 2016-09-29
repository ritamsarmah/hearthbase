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
    func search(for card: String) -> String? {
        let json = getJson()
        for jsonCard in json.arrayValue {
            if (jsonCard["name"].stringValue).lowercased() == card.lowercased() {
                return jsonCard["id"].stringValue
            }
        }
        return nil
    }
    
    // Returns info as JSON for card ID
    func getCard(for id: String) -> JSON {
        let json = getJson()
        for card in json.arrayValue {
            if (card["id"].stringValue == id) {
                return card
            }
        }
        return nil
    }
    
    // Returns data for card image based on ID
    func getCardImageData(withId id: String) -> Data? {
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
    fileprivate func getJson() -> JSON {
        let data = try! Data(contentsOf: url!)
        return JSON(data: data)
    }
    
}
