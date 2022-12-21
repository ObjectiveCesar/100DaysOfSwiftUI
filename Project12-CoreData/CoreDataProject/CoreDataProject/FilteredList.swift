//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Lippmann, Erik on 25.11.22.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    enum PredicateType: String {
        case beginsWith = "BEGINSWITH"
        case contains = "CONTAINS"
        case isEqual = "=="
    }

    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            content(item)
        }
    }

    init(filterKey: String,
         filterValue: String,
         predicateType: PredicateType = .beginsWith,
         sortDescriptors: [SortDescriptor<T>] = [],
         content: @escaping (T) -> Content) {
        self.content = content
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicateType.rawValue) %@", filterKey, filterValue))
    }

    init(filterKey: String,
         filterValue: String,
         predicateString: String = "BEGINSWITH",
         sortDescriptors: [SortDescriptor<T>] = [],
         content: @escaping (T) -> Content) {
        self.content = content
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptor, predicate: NSPredicate(format: "%K \(predicateString) %@", filterKey, filterValue))
    }
}
