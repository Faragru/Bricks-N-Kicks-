//
//  ProfileViewController.swift
//  Bricks'nKicks Store
//
//  Created by Stan Ciprian on 27.07.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var areaPicker: UIPickerView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    
    let currencies = ["USD", "EUR", "GBP", "JPY", "AUD"] // Replace with your preferred currencies
    let accounts = ["Basic", "Premium", "Gold"] // Replace with your account types
    var selectedArea: String = "Global" // Default area selection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        areaPicker.dataSource = self
        areaPicker.delegate = self
        
        // Load saved settings or set default values here
        nameLabel.text = "John Doe"
        addressLabel.text = "123 Main Street, City, Country"
       
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension ProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = currencies[row]
        print("Selected Currency: \(selectedCurrency)")
        // Save the selected currency to your settings or use it as needed
    }
    
    // Customize the appearance of UIPickerView here if needed
}
