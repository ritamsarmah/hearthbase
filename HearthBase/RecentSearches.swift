//
//  RecentSearches.swift
//  HearthBase
//
//  Created by Ritam Sarmah on 10/12/16.
//  Copyright © 2016 Ritam Sarmah. All rights reserved.
//

import Foundation

class RecentSearches {
    
    private struct Constants {
        static let ValuesKey = "RecentSearches.Values"
        static let NumberOfSearches = 100
    }
    
    private let defaults = UserDefaults.standard
    
    var searches: [String] {
        get { return defaults.object(forKey: Constants.ValuesKey) as? [String] ?? [] }
        set { defaults.set(newValue, forKey: Constants.ValuesKey) }
    }
    
    func add(search: String) {
        var currentSearches = searches
        if let index = currentSearches.index(of: search) {
            currentSearches.remove(at: index)
        }
        currentSearches.insert(search, at: 0)
        while currentSearches.count > Constants.NumberOfSearches {
            currentSearches.removeLast()
        }
        searches = currentSearches
    }
    
    func remove(at index: Int) {
        var currentSearches = searches
        currentSearches.remove(at: index)
        searches = currentSearches
    }
    
    func removeAll() {
        var currentSearches = searches
        currentSearches.removeAll()
        searches = currentSearches
    }

}
