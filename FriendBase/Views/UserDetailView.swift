//
//  UserView.swift
//  FriendFace
//
//  Created by Dev Patel on 6/25/23.
//

import SwiftUI

struct UserDetailView: View {
    let user: StoredUser
    
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<StoredUser>
    
    var body: some View {
        ScrollView {
            VStack {
                userInitialsBadge
                                
                aboutSection
                informationSection
                tagsScrollView
                
                friendsList
            }
            .padding(.horizontal)
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func friendIsActive(friend: StoredFriend) -> Bool {
        for user in users {
            if user.wrappedId == friend.wrappedId {
                return user.isActive
            }
        }
        return false
    }
}

extension UserDetailView {
    private var userInitialsBadge: some View {
        Text(user.nameInitials)
            .font(.largeTitle)
            .padding(50)
            .foregroundColor(.primary)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(user.isActive ? .green : .primary, lineWidth: 5)
            )
            .padding(.top)
    }
    
    private var aboutSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("About")
                    .font(.title.bold())
                Spacer()
            }
            .padding(.top)
            ViewDivider()
                .padding(.bottom, 5)
            Text(user.wrappedAbout)
                .font(.subheadline)
        }
    }
    
    private var informationSection: some View {
        VStack {
            HStack {
                Text("Age:")
                    .bold()
                Spacer()
                Text("\(user.age)")
            }
            ViewDivider()
            HStack {
                Text("Company:")
                    .bold()
                Spacer()
                Text("\(user.wrappedCompany)")
            }
            
            ViewDivider()
            
            Group {
                VStack(alignment: .leading) {
                    Text("Email:")
                        .bold()
                    Text("\(user.wrappedEmail)")
                }
                ViewDivider()
                VStack(alignment: .leading) {
                    Text("Address:")
                        .bold()
                    Text("\(user.wrappedAddress)")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.gray)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var friendsList: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Friends")
                    .font(.title.bold())
                Spacer()
            }
            .padding(.top)
            ViewDivider()
                .padding(.bottom, 5)
            
            ForEach(user.friendsArray) { friend in
                HStack {
                    ActiveIndicator(isActive: friendIsActive(friend: friend))
                    Text(friend.wrappedName)
                }
            }
        }
    }
    
    private var tagsScrollView: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Tags")
                    .font(.headline.bold())
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(user.wrappedTags.components(separatedBy: ","), id: \.self) { tag in
                        Text(tag)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .overlay(
                                Capsule()
                                    .strokeBorder(.primary, lineWidth: 2)
                            )
                    }
                }
            }
        }
    }
}
