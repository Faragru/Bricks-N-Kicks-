//
//  AllProductsViewController.swift
//  Bricks'nKicks Store
//
//  Created by Stan Ciprian on 02.08.2023.
//

import UIKit

class AllProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var ProductCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var sneakers: [Sneaker] = []   // Store all sneakers
    var filteredSneakers: [Sneaker] = []   //Store all filtered sneakers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductCollectionView.dataSource = self
        ProductCollectionView.delegate = self
        searchBar.delegate = self
        filteredSneakers = sneakers
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
                    ProductCollectionView.reloadData()
                    // Display random sneakers in the randomSneakerCollectionView
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }

    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sneakers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        let sneaker = sneakers[indexPath.item]

        cell.configure(photoURL: sneaker.photoURL, name: sneaker.model, price: sneaker.price)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSneaker = sneakers[indexPath.item]
        
        // Pass the selected sneaker to the detail view controller
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "SneakerDetailViewController") as? SneakerDetailViewController {
            detailViewController.sneaker = selectedSneaker
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Trim leading and trailing whitespaces from the search text
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check if the trimmed search text is empty
        if trimmedSearchText.isEmpty {
            // If it's empty, show all sneakers
            filteredSneakers = sneakers
        } else {
            // Filter the sneakers based on the search text (case-insensitive)
            filteredSneakers = sneakers.filter { $0.model.lowercased().contains(trimmedSearchText.lowercased()) }
        }
        
        // Reload the collection view to reflect the filtered data
        ProductCollectionView.reloadData()
    }

}


