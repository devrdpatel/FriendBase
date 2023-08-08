//
//  FilteredList.swift
//  FriendBase
//
//  Created by Dev Patel on 8/4/23.
//

import CoreData
import SwiftUI

/// This is a generic View that creates a List after making a FetchRequest for the given type, which will
/// filter the data based on the given parameters for PredicateKey, sortDescriptors, filterKey and filterValue.
/// Currently, the list requires a predicateKey but if an empty string is given as the filterValue, no predicate
/// is actually in filtering the list of objects.
///
/// More predicate key options will be added as additional sort features are implemented.
///
struct FilteredList<T: NSManagedObject, Content: View>: View {
    
    // These are used to filter the Core Data stored entities
    enum PredicateKeys: String {
        case contains = "CONTAINS[c]"
    }
    
    @FetchRequest var fetchedResults: FetchedResults<T>
    
    // This is the content for what each list row should contain
    let content: (T) -> Content
    
    // Creates the FetchRequest and stores the content closure for later use
    init(filterKey: String, filterValue: String, predicateKey: PredicateKeys, sortDescriptors: [SortDescriptor<T>] = [], @ViewBuilder content: @escaping (T) -> Content) {
        let predicate: NSPredicate? = filterValue.isEmpty ? nil : NSPredicate(format: "%K \(predicateKey) %@", filterKey, filterValue)
        _fetchedResults = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: predicate)
        self.content = content
    }
    
    // Creates a list with the given content closure
    var body: some View {
        List(fetchedResults, id: \.self) { item in
            self.content(item)
        }
    }
}
