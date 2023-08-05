//
//  ActiveIndicator.swift
//  FriendBase
//
//  Created by Dev Patel on 8/5/23.
//

import SwiftUI

struct ActiveIndicator: View {
    let isActive: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(isActive ? .green : .gray)
            VStack {
                HStack {
                    Spacer()
                    Circle()
                        .fill(.white)
                }
                Spacer()
            }
        }
        .frame(width: 15, height: 15)
        .overlay(
            Circle()
                .strokeBorder(isActive ? .green : .gray, lineWidth: 2)
        )
        .clipShape(Circle())
    }
}

struct ActiveIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActiveIndicator(isActive: false)
    }
}
