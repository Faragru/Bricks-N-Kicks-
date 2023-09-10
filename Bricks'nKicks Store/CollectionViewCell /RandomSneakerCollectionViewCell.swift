//
//  RandomSneakerCollectionViewCell.swift
//  Bricks'nKicks Store
//
//  Created by Stan Ciprian on 02.08.2023.
//
import UIKit

class RandomSneakerCollectionViewCell: UICollectionViewCell {
    @IBOutlet var sneakerPhoto: UIImageView!
    @IBOutlet var sneakerName: UILabel!
    @IBOutlet var sneakerPrice: UILabel!
    
    func configure(photoURL: String, name: String, price: Int) {
        // Set the photo
        if let photoURL = URL(string: photoURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: photoURL),
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
        
        // Set the labels
        self.sneakerName.text = name
        self.sneakerPrice.text = "\(price)" + "$"
    }
}

