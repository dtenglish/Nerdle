//
//  DataManager.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 10/13/22.
//

import SwiftUI

struct DataManager<T: Codable> {
    
    func getUserData(key: String) -> T? {
        if verifyCloudAccount() {
            print("attempting to get user data from iCloud")
            guard let data = NSUbiquitousKeyValueStore().object(forKey: key) as? Data else {
                print("error retrieving user data from iCloud")
                return nil
            }
            return decodeUserData(data)
        } else {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                print("no data found in user defaults")
                return nil
            }
            return decodeUserData(data)
        }
    }
    
    func setUserData(key: String, data: T) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            
            if verifyCloudAccount() {
                print("attempting to store user data in iCloud")
                NSUbiquitousKeyValueStore().set(encodedData, forKey: key)
                NSUbiquitousKeyValueStore().synchronize()
            } else {
                UserDefaults.standard.set(encodedData, forKey: key)
            }
        } catch {
            print("error storing user data:\n\(error)")
        }
    }
    
    func decodeUserData(_ data: Data) -> T? {
        do {
            let value = try JSONDecoder().decode(T.self, from: data)
            return value
        } catch {
            print("error encoding user data:\n\(error)")
            return nil
        }
    }
    
    func verifyCloudAccount() -> Bool {
        print("attempting to verify iCloud account")
        if FileManager.default.ubiquityIdentityToken != nil {
            print("iCloud account confirmed")
            return true
        } else {
            print("No iCloud account found")
            return false
        }
    }
}
