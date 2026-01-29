//
//  ListView.swift
//  weatherapp
//
//  Created by rentamac on 1/22/26.
//
import SwiftUI
import Foundation
struct ListView: View {
    @StateObject private var example = ListViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundcolour")
                    .ignoresSafeArea()
                List {
                    
                    ForEach(example.filteredLocations) { location in
                        NavigationLink {
                          DetailView(location: location)
                        } label: {
                            HStack {
                                
                                Text(location.name)
                                    .foregroundColor(.white)
                                    .font(.headline)

                                Spacer()

                                Image(systemName: location.weather.iconName)
                                    .foregroundColor(.yellow)
                            }
                            .padding(.vertical, 10)
                        }
                        .listRowBackground(Color("backgroundcolour"))
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
//            .navigationTitle("Locations")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
            ToolbarItem(placement: .principal) {
            Text("Locations")
            .foregroundColor(.white)
              }
            }
            .navigationBarTitleDisplayMode(.large)
            .searchable(
                text: $example.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search"
            )
        }
    }
}

#Preview{
    ListView()
}
