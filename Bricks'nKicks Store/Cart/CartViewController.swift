//
//  CartViewController.swift
//  Bricks'nKicks Store
//
//  Created by Stan Ciprian on 02.08.2023.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    var sneakers: [Sneaker] = []  // This should contain the selected sneakers in the cart
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
       // updateTotalPriceLabel()
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sneakers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let sneaker = sneakers[indexPath.row]
        
        cell.textLabel?.text = sneaker.model
        cell.imageView?.loadImage(from: sneaker.photoURL)
        
        return cell
    }
    
    func calculateTotalPrice() -> Double {
        let totalPrice = sneakers.reduce(0.0) { $0 + Double($1.price) }
        return totalPrice
    }

//    func updateTotalPriceLabel() {
//        totalLabel.text = "Total Price: $\(calculateTotalPrice())"
//    }
}

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to load image: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        
        }.resume()
    }
}
