//
//  FilteredList.swift
//  FriendBase
//
//  Created by Dev Patel on 8/4/23.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    
    enum PredicateKeys: String {
        case contains = "CONTAINS[c]"
    }
    
    @FetchRequest var fetchedResults: FetchedResults<T>
    let content: (T) -> Content
    
    // Creates the FetchRequest and stores the content closure for later use
    init(filterKey: String, filterValue: String, predicateKey: PredicateKeys, sortDescriptors: [SortDescriptor<T>] = [], @ViewBuilder content: @escaping (T) -> Content) {
        _fetchedResults = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicateKey) %@", filterKey, filterValue))
        self.content = content
    }
    
    // Creates a list with the given content closure
    var body: some View {
        List(fetchedResults, id: \.self) { item in
            self.content(item)
        }
    }
}
