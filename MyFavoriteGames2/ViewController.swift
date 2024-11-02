//
//  ViewController.swift
//  MyFavoritesCollection
//
//  Created by мак on 01.11.2024.
//

import UIKit

struct Game {
    let title: String
    let image: UIImage
    let description: String
    let platform: String
    let releaseYear: Int
    var isFavorite: Bool
}


class ViewController: UIViewController, FavoriteGameTableCellDelegate {
    @IBOutlet weak var favoriteGamesTableView: UITableView!
    
    var favoriteGames: [Game] = [
        Game(title: "CS2", image: UIImage(named: "cs2")!, description: "description", platform: "Steam", releaseYear: 2023, isFavorite: false),
        Game(title: "Battlefield 1", image: UIImage(named: "bf1")!, description: "description", platform: "Steam", releaseYear: 2015, isFavorite: false),
        Game(title: "Battlefield 5", image: UIImage(named: "bf5")!, description: "description", platform: "Steam", releaseYear: 2018, isFavorite: false),
        Game(title: "Metro Exodus", image: UIImage(named: "metro")!, description: "description", platform: "Steam", releaseYear: 2019, isFavorite: false),
        Game(title: "GTA V", image: UIImage(named: "gta5")!, description: "description", platform: "Steam", releaseYear: 2013, isFavorite: false),
        Game(title: "Days Gone", image: UIImage(named: "daysgone")!, description: "description", platform: "Steam", releaseYear: 2020, isFavorite: false),
        Game(title: "Sniper Elite 4", image: UIImage(named: "se4")!, description: "description", platform: "Steam", releaseYear: 2016, isFavorite: false),
        Game(title: "Witcher 3", image: UIImage(named: "witcher3")!, description: "description", platform: "Steam", releaseYear: 2012, isFavorite: false),
        Game(title: "FarCry 5", image: UIImage(named: "fc5")!, description: "description", platform: "Steam", releaseYear: 2018, isFavorite: false),
        Game(title: "Dying Light", image: UIImage(named: "dyinglight")!, description: "description", platform: "Steam", releaseYear: 2015, isFavorite: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteGamesTableView.dataSource = self
        favoriteGamesTableView.delegate = self
        favoriteGamesTableView.register(FavoriteGameTableCell.nib(), forCellReuseIdentifier: FavoriteGameTableCell.identifier)
    }
    
    @IBAction func showFavorites(_ sender: UIButton) {
        favoriteGames = favoriteGames.filter { $0.isFavorite }
        favoriteGamesTableView.reloadData()
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteGames.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailsViewController: GameDetailsViewController = storyboard.instantiateViewController(withIdentifier: "gameDetailsViewController") as! GameDetailsViewController
        detailsViewController.navigationItem.title = favoriteGames[indexPath.row].title
        detailsViewController.game = favoriteGames[indexPath.row]
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteGameTableCell.identifier, for: indexPath) as! FavoriteGameTableCell
        
        let game = favoriteGames[indexPath.row]
        cell.configure(game.image, game.title)
        
        cell.delegate = self
        
        if game.isFavorite {
            cell.backgroundColor = UIColor.yellow
        }
        
        return cell
    }
    
    func didAddGameToFavorites(_ cell: FavoriteGameTableCell) {
            if let indexPath = favoriteGamesTableView.indexPath(for: cell) {
                favoriteGames[indexPath.row].isFavorite = true
                favoriteGamesTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
}
