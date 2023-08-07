//
//  UserDataService.swift
//  FriendBase
//
//  Created by Dev Patel on 8/7/23.
//

import Foundation

class UserDataService {
    static func fetchUserData() async -> [User]? {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            fatalError("The given url is not valid")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decoded = try? decoder.decode([User].self, from: data) {
                return decoded
            }
        } catch {
            fatalError("Invalid Data that could not be loaded/decoded")
        }
        fatalError("Invalid Data that could not be loaded/decoded")
    }
}
