//
//  UsersViewModel.swift
//  FriendBase
//
//  Created by Dev Patel on 8/7/23.
//

import CoreData
import Foundation
import SwiftUI

@MainActor class UsersDataManager {

    static let shared = UsersDataManager()
    
    private init() { }
    
    let userDataService = UserDataService()
    
    func updateCachedUsers(_ cachedUsers: FetchedResults<StoredUser>, moc: NSManagedObjectContext) async {
    
        if let fetchedUsers = await UserDataService.fetchUserData() {
            for user in fetchedUsers {
                let newUser = StoredUser(context: moc)
                newUser.id = user.id
                newUser.name = user.name
                newUser.isActive = user.isActive
                
                newUser.age = Int16(user.age)
                newUser.company = user.company
                newUser.email = user.email
                newUser.address = user.address
                
                newUser.about = user.about
                newUser.registered = user.registered
                newUser.tags = user.tags.joined(separator: ",")
                
                for friend in user.friends {
                    let newFriend = StoredFriend(context: moc)
                    newFriend.name = friend.name
                    newFriend.id = friend.id
                    newUser.addToFriends(newFriend)
                }
            }
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}
