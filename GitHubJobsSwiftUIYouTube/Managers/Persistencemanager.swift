//
//  Persistencemanager.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/28/21.
//

import Combine
import Foundation

class PersistenceManager: ObservableObject{
    static let shared = PersistenceManager()
    public var showAlertForAlreadySavedJobs = false
    private init(){}
    
    @UserDefaultCodable("savedItems", defaultValue: [])
    var savedItems: [Job]{
        willSet {
            objectWillChange.send()
        }
    }
}

@propertyWrapper
public struct UserDefaultCodable<T: Codable> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            if let data = UserDefaults.standard.data(forKey: key) {
                if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                    return decoded
                }
            }
            return self.defaultValue
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}
