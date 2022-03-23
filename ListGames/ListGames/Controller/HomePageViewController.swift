//
//  HomePageViewController.swift
//  ListGames
//
//  Created by Yağmur Polat on 12.03.2022.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var gameFiltered: [GameResult] = [GameResult]()
    var isFiltering: Bool = false
    
    var games = [GameResult]() {
        didSet {
            DispatchQueue.main.async {
                self.listCollectionView.reloadData()
            }
        }
    }
    
    
    
    let gameRequest = GameRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCollectionView.register(UINib(nibName: "GameCell", bundle: .main), forCellWithReuseIdentifier: "gameCell")
        

        gameRequest.getGame { result in
            switch result {
            case .success(let games):
                self.games = games.results
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
 
    }
    
    
    

}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering {
            return gameFiltered.count
        }
        return games.count
        
        /*
        if collectionView == self.sliderCollectionView {
            return 3
        }
        
        return games.count */
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isFiltering {
            if collectionView == self.sliderCollectionView {
                let sliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "slideImageCell", for: indexPath) as! SlideImageCell
                return sliderCell
            }
            else {
                let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GameCell
                gameCell.name.text = gameFiltered[indexPath.row].name
                gameCell.rating.text = String(gameFiltered[indexPath.row].rating)
                gameCell.released.text = gameFiltered[indexPath.row].released
                gameCell.image.loadFrom(URLAddress: games[indexPath.row].background_image)
                
                
                return gameCell
            }
        } else {
            if collectionView == self.sliderCollectionView {
                let sliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "slideImageCell", for: indexPath) as! SlideImageCell
                return sliderCell
            }
            else {
                let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GameCell
                gameCell.name.text = games[indexPath.row].name
                gameCell.rating.text = String(games[indexPath.row].rating)
                gameCell.released.text = games[indexPath.row].released
                gameCell.image.loadFrom(URLAddress: games[indexPath.row].background_image)
                
                return gameCell
            }
        }
        
    }
    
    
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
