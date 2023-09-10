//
//  Struct.swift
//  Bricks'nKicks Store
//
//  Created by Stan Ciprian on 31.07.2023.
//
struct Sneaker: Codable, Equatable {
    let id: Int
    let brand: String
    let model: String
    let releaseDate: String
    let price: Int
    let currency: String
    let rating: Double
    let photoURL: String
    let sizes: [String]

    enum CodingKeys: String, CodingKey {
        case id, brand, model, price, currency, rating, sizes
        case releaseDate = "release_date"
        case photoURL = "photo_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            id = try container.decode(Int.self, forKey: .id)
            brand = try container.decode(String.self, forKey: .brand)
            model = try container.decode(String.self, forKey: .model)
            releaseDate = try container.decode(String.self, forKey: .releaseDate)
            price = try container.decode(Int.self, forKey: .price)
            currency = try container.decode(String.self, forKey: .currency)
            rating = try container.decode(Double.self, forKey: .rating)
            photoURL = try container.decode(String.self, forKey: .photoURL)
            sizes = try container.decode([String].self, forKey: .sizes)
        } catch {
            // Handle any decoding errors here
            // For example, you can set default values or throw a custom error
            // You can also log the error for debugging purposes
            print("Error decoding Sneaker: \(error)")
            throw error
        }
    }
}





