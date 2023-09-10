//
//  AppDelegate.swift
//  Bricks'nKicks Store
//
//  Created by Stan Ciprian on 26.07.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
        var sneakers: [Sneaker] = [] 

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Load data into the shared data source array
            if let path = Bundle.main.path(forResource: "SneakersAPI", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path))
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let sneakerData = jsonData?["sneakers"] as? [[String: Any]] {
                        let decoder = JSONDecoder()
                        sneakers = try sneakerData.map { try decoder.decode(Sneaker.self, from: JSONSerialization.data(withJSONObject: $0)) }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            
            return true
        }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

