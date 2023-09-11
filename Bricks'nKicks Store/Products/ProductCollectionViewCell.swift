//
//  ProductCollectionViewCell.swift
//  Bricks'nKicks Store
//
//  Created by Stan Ciprian on 11.09.2023.
//
import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var productPhoto: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    func configure(photoURL: String, name: String, price: Int) {
        // Set the product photo
        if let url = URL(string: photoURL) {
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data) else {
                    // Set a default image or placeholder image
                    DispatchQueue.main.async {
                        self.productPhoto.image = UIImage(named: "defaultImage")
                    }
                    return
                }
                
                // Set the product photo on the main thread
                DispatchQueue.main.async {
                    self.productPhoto.image = image
                }
            }
        } else {
            // Set a default image or placeholder image
            self.productPhoto.image = UIImage(named: "defaultImage")
        }
        
    
        self.productName.text = name
        self.productPrice.text = "\(price)$"
    }
}

