//
//  User+Friend.swift
//  FriendFace
//
//  Created by Dev Patel on 6/25/23.
//

import Foundation


/// These structs are only used for decoding the fetched JSON data and copying it to CoreData

struct User: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    
    let age: Int
    let company: String
    let email: String
    let address: String
    
    let about: String
    let registered: Date
    let tags: [String]
    var friends: [Friend]
}

struct Friend: Codable, Identifiable {
    let id: String
    let name: String
}
