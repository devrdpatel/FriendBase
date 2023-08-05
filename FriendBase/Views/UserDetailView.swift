//
//  UserView.swift
//  FriendFace
//
//  Created by Dev Patel on 6/25/23.
//

import SwiftUI

struct ViewDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.secondary)
    }
}

struct InformationView: View {
    let user: StoredUser
    
    var body: some View {
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
}

struct UserDetailView: View {
    //@ObservedObject var userData: UserData
    let user: StoredUser
    
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<StoredUser>
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
//                    Image(systemName: "person.circle")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: geometry.size.width * 0.3)
//                        .foregroundColor(.secondary)
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
                    
                    ViewDivider()
                        .padding(.vertical)
                                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("About \(user.wrappedName)")
                                .font(.title.bold())
                                .padding(.bottom, 1)
                            Spacer()
                        }
                        Text(user.wrappedAbout)
                            .font(.subheadline)
                    }
                    
                    InformationView(user: user)
                    
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
                    
                    ViewDivider()
                        .padding(.vertical)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Friends")
                                .font(.title.bold())
                                .padding(.bottom, 1)
                            Spacer()
                        }
                        
                        ForEach(user.friendsArray) { friend in
                            HStack {
                                ActiveIndicator(isActive: friendIsActive(friend: friend))
                                Text(friend.wrappedName)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
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
