//
//  SneakerDetailViewController.swift
//  Bricks'nKicks Store
//
//  Created by Stan Ciprian on 01.08.2023.
//

import UIKit

class SneakerDetailViewController: UIViewController {
    
    @IBOutlet weak var sneakerImageView: UIImageView!
    @IBOutlet weak var sneakerDetails: UILabel!
    @IBOutlet weak var sneakerPrice: UILabel!
    @IBOutlet var sizeSelectionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var sneakerNameLabel: UILabel!
    
    
    // Add other UI elements as needed for options, add to cart, and add to favorite.
    
    var sneaker: Sneaker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        if let sneaker = sneaker {
            // Set the image for the sneaker
            if let photoURL = URL(string: sneaker.photoURL) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: photoURL),
                       let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.sneakerImageView.image = image
                        }
                    } else {
                        // Set a default image or placeholder image
                        DispatchQueue.main.async {
                            self.sneakerImageView.image = UIImage(named: "defaultImage")
                        }
                    }
                }
            } else {
                // Set a default image or placeholder image
                self.sneakerImageView.image = UIImage(named: "defaultImage")
            }
            
            // Set up the size selection segmented control
            sizeSelectionSegmentedControl.removeAllSegments()
            for (index, size) in sneaker.sizes.enumerated() {
                sizeSelectionSegmentedControl.insertSegment(withTitle: "\(size)", at: index, animated: false)
            }
            // Optionally, you can set the default selected size or handle selection events.
            
            // Update other UI elements with the selected sneaker data
            sneakerNameLabel.text = sneaker.model
            sneakerPrice.text = "\(sneaker.price)" + "$"
            // Set other data like sneaker details and ratingsLabel.
            // You can use the outlets you previously connected in the storyboard.
        }
    }
    
}
