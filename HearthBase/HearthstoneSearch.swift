//
//  HearthstoneSearch.swift
//  HearthBase
//
//  Created by Ritam Sarmah on 9/11/16.
//  Copyright © 2016 Ritam Sarmah. All rights reserved.
//

import Foundation

class HearthstoneSearch {
    let url = URL(string: "https://api.hearthstonejson.com/v1/13921/enUS/cards.collectible.json")
    let cardImageUrl = "http://wow.zamimg.com/images/hearthstone/cards/enus/original/"
    
    // Returns card ID as String
    func search(for card: String) -> String? {
        let json = getJson()
        for json_card in json {
            if (json_card["name"] as! String).lowercased() == card.lowercased() {
                return json_card["id"] as? String
            }
        }
        return nil
    }
    
    func getCard(for id: String) -> [String:AnyObject]? {
        let json = getJson()
        for json_card in json {
            if (json_card["id"] as! String == id) {
                return json_card
            }
        }
        return nil
    }
    
    fileprivate func getJson() -> [[String:AnyObject]] {
        let data = try! Data(contentsOf: url!)
        return try! JSONSerialization.jsonObject(with: data) as! [[String:AnyObject]]
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
}
