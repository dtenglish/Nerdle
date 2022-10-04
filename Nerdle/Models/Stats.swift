//
//  Stats.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 10/4/22.
//

import Foundation

struct Stats: Codable {
    var wins: [Int] = [Int](repeating: 0, count: 6)
    var totalGames: Int = 0
    var currentStreak: Int = 0
    var highestStreak: Int = 0
    
    var totalWins: Int {
        wins.reduce(0, +)
    }
}
