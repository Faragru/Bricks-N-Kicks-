//
//  ProductCollectionViewCell.swift
//  Bricks'nKicks Store
//
//  Created by Stan Ciprian on 11.09.2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var sneakerPhoto: UIImageView!
    @IBOutlet var sneakerName: UILabel!
    @IBOutlet var sneakerPrice: UILabel!
    
    func configure(sneaker: Sneaker) {
        // Set the product photo
        if let url = URL(string: sneaker.photoURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.sneakerPhoto.image = image
                    }
                } else {
                    // Set a default image or placeholder image
                    DispatchQueue.main.async {
                        self.sneakerPhoto.image = UIImage(named: "defaultImage")
                    }
                }
            }
        } else {
            // Set a default image or placeholder image
            self.sneakerPhoto.image = UIImage(named: "defaultImage")
        }
        
        
        // Update other UI elements with the selected sneaker data
        sneakerName.text = sneaker.model
        sneakerPrice.text = "\(sneaker.price)" + "$"
        // Set other data like sneaker details and ratingsLabel.
        // You can use the outlets you previously connected in the storyboard.
    }
}
