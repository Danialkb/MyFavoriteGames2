//
//  FavoriteGameTableCell.swift
//  MyFavoriteGames2
//
//  Created by мак on 01.11.2024.
//

import UIKit

protocol FavoriteGameTableCellDelegate: AnyObject {
    func didAddGameToFavorites(_ cell: FavoriteGameTableCell)
}

class FavoriteGameTableCell: UITableViewCell {
    static let identifier = "tableCell"
    
    weak var delegate: FavoriteGameTableCellDelegate?
    
    @IBOutlet weak var gameImageView: UIImageView!
    
    @IBOutlet weak var gameTitleLabel: UILabel!
        
    func configure(_ gameImage: UIImage, _ gameTitle: String) {
        gameImageView.image = gameImage
        gameTitleLabel.text = gameTitle
    }
    
    @IBAction func addGameToFavorites(_ sender: UIButton) {
        delegate?.didAddGameToFavorites(self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FavoriteGameTableCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
