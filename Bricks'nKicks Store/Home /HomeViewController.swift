//
//  HomeViewController.swift
//  Bricks'nKicks Store
//
//  Created by Stan Ciprian on 27.07.2023.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var sneakerCollectionView: UICollectionView!
    @IBOutlet var randomSneakerCollectionView: UICollectionView!
    
    var sneakers: [Sneaker] = [] 

    var randomSneakers: [Sneaker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sneakerCollectionView.dataSource = self
        sneakerCollectionView.delegate = self
        randomSneakerCollectionView.dataSource = self
        randomSneakerCollectionView.delegate = self
        loadSneakerData()
    }
    
    func loadSneakerData() {
        if let path = Bundle.main.path(forResource: "SneakersAPI", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let sneakerData = jsonData?["sneakers"] as? [[String: Any]] {
                    let decoder = JSONDecoder()
                    sneakers = try sneakerData.map { try decoder.decode(Sneaker.self, from: JSONSerialization.data(withJSONObject: $0)) }
                    sneakerCollectionView.reloadData()
                    // Display random sneakers in the randomSneakerCollectionView
                    displayRandomSneakers()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }

    func displayRandomSneakers() {
        // Shuffle the sneakers array to get a random order
        randomSneakers = sneakers.shuffled().prefix(12).map { $0 }
        randomSneakerCollectionView.reloadData()
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sneakerCollectionView {
            return sneakers.count
        } else if collectionView == randomSneakerCollectionView {
            return randomSneakers.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sneakerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SneakerCell", for: indexPath) as! SneakerCollectionViewCell
            let sneaker = sneakers[indexPath.item]
            
            // Set the photo and labels in the collection view cell using the SneakerCollectionViewCell
            cell.configure(photoURL: sneaker.photoURL, name: sneaker.model, price: sneaker.price)
            
            return cell
        } else if collectionView == randomSneakerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomSneakerCell", for: indexPath) as! RandomSneakerCollectionViewCell
            let sneaker = randomSneakers[indexPath.item]
            
            // Configure the cell to display the random sneakers
            cell.configure(photoURL: sneaker.photoURL, name: sneaker.model, price: sneaker.price)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sneakerCollectionView {
            let selectedSneaker = sneakers[indexPath.item]
            // Pass the selected sneaker to the detail view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailViewController = storyboard.instantiateViewController(withIdentifier: "SneakerDetailViewController") as? SneakerDetailViewController {
                detailViewController.sneaker = selectedSneaker
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        } else if collectionView == randomSneakerCollectionView {
            // Handle tap on the random sneakers in the randomSneakerCollectionView
        }
    }



    
    func displaySneakerData(sneaker: Sneaker) {
        // Update the UI elements with the selected sneaker data
        // For example, you can use the outlets you previously connected in the storyboard
        // SneakerPhoto.image = the image of the selected sneaker
        // SneakerName.text = the model name of the selected sneaker
        // SneakerPrice.text = the price of the selected sneaker
    }
}
