//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Alex Nguyen on 2023-07-03.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(sortArray: [SortDescriptor<T>], filterKey: String, filterOption: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest(sortDescriptors: sortArray, predicate: NSPredicate(format: "%K \(filterOption) %@", filterKey, filterValue))
        self.content = content
    }
}
