//
//  Game.swift
//  ListGames
//
//  Created by Yağmur Polat on 12.03.2022.
//

import Foundation

struct Game: Decodable {
    let results: [GameResult]
}

struct GameResult: Decodable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let background_image: String
    let rating: Double
}
