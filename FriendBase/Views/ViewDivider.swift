//
//  ViewDivider.swift
//  FriendBase
//
//  Created by Dev Patel on 8/6/23.
//

import SwiftUI

struct ViewDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.secondary)
    }
}

struct ViewDivider_Previews: PreviewProvider {
    static var previews: some View {
        ViewDivider()
    }
}
