import UIKit

let url = URL(string: "https://api.hearthstonejson.com/v1/13921/enUS/cards.json")
let cardImageUrl = "http://wow.zamimg.com/images/hearthstone/cards/enus/original/"
let ignoredSets = ["HERO_SKINS","KARA_RESERVE", "MISSIONS", "NONE", "TB", "CREDITS", "CHEAT"]
let ignoredTypes = ["ENCHANTMENT", "HERO", "HERO_POWER"]

func search(forCard cardName: String){
    let data = try! Data(contentsOf: url!)
    let json = try! JSONSerialization.jsonObject(with: data) as! [[String:AnyObject]]
    
    for card in json {
        if !ignoredSets.contains(card["set"] as! String) && !ignoredTypes.contains(card["type"] as! String) {
            if (card["name"] as! String).lowercased() == cardName.lowercased() {
                
                // Get card iamge
                let id = card["id"] as! String
                let imageURL = URL(string: cardImageUrl + id + ".png")
                let imageData = try! Data(contentsOf: imageURL!)
                let image = UIImage(data: imageData)

                return
            }
        }
    }
    print("Card was not found")
    
}

search(forCard: "ragnaros the firelord")
