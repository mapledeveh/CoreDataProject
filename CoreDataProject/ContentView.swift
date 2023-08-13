//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Alex Nguyen on 2023-07-01.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    @State private var filterKey = FilterKeys.name
    @State private var filterOption = FilterOptions.beginsWith
    @State private var filterValue = "T"

    let sortArray = [
        SortDescriptor<Candy>(\.name, order: .reverse),
        SortDescriptor<Candy>(\.origin?.shortName),
        SortDescriptor<Candy>(\.origin?.fullName)
    ]
        
    enum FilterKeys: String, CaseIterable {
        case name = "name"
        case shortName = "origin.shortName"
        case fullName = "origin.fullName"
        
        var name: String {
            switch self {
            case .name: return "Candy Name"
            case .shortName: return "Short Name"
            case .fullName: return "Full Name"
            }
        }
    }
    
    enum FilterOptions: String, CaseIterable {
        case beginsWith = "BEGINSWITH"
        case contains = "CONTAINS"
        case beginsWithCI = "BEGINSWITH[C]"
        case containsCI = "CONTAINS[C]"
        
        var name: String {
            switch self {
                case .beginsWith: return "Begins With"
                case .contains: return "Contains"
                case .beginsWithCI: return "Case-Insensitively Begins With"
                case .containsCI: return "Case-Insensitively Contains"
            }
        }
    }
    
    var body: some View {
        VStack {
            FilteredList(sortArray: sortArray, filterKey: filterKey.rawValue, filterOption: filterOption.rawValue, filterValue: filterValue) { (candy: Candy) in
                Text(candy.wrappedName)
            }
            
            VStack {
                Button("Add Examples") {
                    let candy1 = Candy(context: moc)
                    candy1.name = "Mars"
                    candy1.origin = Country(context: moc)
                    candy1.origin?.shortName = "UK"
                    candy1.origin?.fullName = "United Kingdom"
                    
                    let candy2 = Candy(context: moc)
                    candy2.name = "KitKat"
                    candy2.origin = Country(context: moc)
                    candy2.origin?.shortName = "UK"
                    candy2.origin?.fullName = "United Kingdom"
                    
                    let candy3 = Candy(context: moc)
                    candy3.name = "Twix"
                    candy3.origin = Country(context: moc)
                    candy3.origin?.shortName = "UK"
                    candy3.origin?.fullName = "United Kingdom"
                    
                    let candy4 = Candy(context: moc)
                    candy4.name = "Toblerone"
                    candy4.origin = Country(context: moc)
                    candy4.origin?.shortName = "CH"
                    candy4.origin?.fullName = "Switzerland"
                    
                    if moc.hasChanges { try? moc.save() }
                }
                
                Form {
                    Picker("Filter Key", selection: $filterKey) {
                        ForEach(FilterKeys.allCases, id: \.self) { key in
                            Text(key.name)
                        }
                    }
                    
                    Picker("Filter Option", selection: $filterOption) {
                        ForEach(FilterOptions.allCases, id: \.self) { option in
                            Text(option.name)
                        }
                    }
                    
                    HStack {
                        Text("Filter Value")
                        TextField("Filter Value", text: $filterValue)
                            .multilineTextAlignment(.trailing)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
