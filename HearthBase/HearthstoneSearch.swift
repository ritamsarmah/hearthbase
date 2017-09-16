//
//  HearthstoneSearch.swift
//  HearthBase
//
//  Created by Ritam Sarmah on 9/11/16.
//  Copyright © 2016 Ritam Sarmah. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HearthstoneSearch {
    
    private let url = "https://omgvamp-hearthstone-v1.p.mashape.com/cards"
    
    // Returns card ID as String
    func search(for searchText: String, completionHandler: @escaping ([Card], Error?) -> ()) {
        
        let searchRequest = "https://omgvamp-hearthstone-v1.p.mashape.com/cards/search/\(searchText)?collectible=1"
        var cards = [Card]() // Cards matching from front
        var secondary = [Card]() // Card matching with substring
        var raceCards = [Card]() // Cards matching with race
        
        Alamofire.request(searchRequest, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                for card in json.arrayValue {
                    
                    // Ignores hero data in JSON
                    if card["type"].stringValue == "Hero" {
                        continue
                    }
                    
                    let name = card["name"].stringValue.lowercased()
                    let race = card["race"].stringValue.lowercased()
                    
                    if name.contains(searchText.lowercased()) {
                        let newCard = Card(with: card)
                        
                        // Checks if searchText matches first word
                        if name.hasPrefix(searchText.lowercased()) {
                            cards.append(newCard)
                        } else {
                            secondary.append(newCard)
                        }
                    } else if race.contains(searchText.lowercased()) {
                        let newCard = Card(with: card)
                        raceCards.append(newCard)
                    }
                }
                cards.append(contentsOf: secondary)
                cards.append(contentsOf: raceCards)
                completionHandler(cards, nil)
            case .failure(let error):
                completionHandler(cards, error)
            }
        }
    }
    
    // Returns card based on card ID
    func getCard(withId id: String, completionHandler: @escaping (Card?, Error?) -> ()) {
        let searchRequest = "https://omgvamp-hearthstone-v1.p.mashape.com/cards/\(id)?collectible=1"
        headers["Accept"] = "application/json"
        Alamofire.request(searchRequest, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                print(json)
                completionHandler(self.createCard(with: json), nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, error)
            }
        }
    }
    
    // Returns data for card image based on ID
    func getImageData(for card: Card) -> Data? {
        do {
            let data = try Data(contentsOf: card.img)
            return data
        } catch {
            print(error)
            return nil
        }
    }
    
    // MARK: Helper Functions
    
    private func createCard(with json: JSON) -> Card {
        return Card(with: json.arrayValue.first!)
    }
    
}
