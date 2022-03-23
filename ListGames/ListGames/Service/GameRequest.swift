//
//  GameRequest.swift
//  ListGames
//
//  Created by Yağmur Polat on 12.03.2022.
//

import Foundation

enum GameError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct GameRequest {
    
    let resourceURL: URL
    
    init() {
        let resourceString = "https://api.rawg.io/api/games?key=b4baa22e4bec404dae386704b19a98e7"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("Error")
        }
        self.resourceURL = resourceURL
    }
    
    func getGame(completion: @escaping(Result<Game, GameError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let games = try decoder.decode(Game.self, from: jsonData)
                completion(.success(games))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
    
}
