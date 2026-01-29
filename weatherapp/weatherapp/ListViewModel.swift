import SwiftUI
import Combine

final class ListViewModel: ObservableObject {

    @Published var searchText: String = ""

    @Published var locations: [Location] = [

        Location(
            name: "Mumbai",
            weather: .sunny,
            temperature: Temperature(min: 22, max: 32),
            latitude: 19.0760,
            longitude: 72.8777
        ),

        Location(
            name: "Delhi",
            weather: .rainy,
            temperature: Temperature(min: 12, max: 22),
            latitude: 28.6139,
            longitude: 77.2090
        ),

        Location(
            name: "Pune",
            weather: .windy,
            temperature: Temperature(min: 18, max: 28),
            latitude: 18.5204,
            longitude: 73.8567
        ),

        Location(
            name: "Bangalore",
            weather: .sunny,
            temperature: Temperature(min: 25, max: 35),
            latitude: 12.9716,
            longitude: 77.5946
        ),

        Location(
            name: "Chennai",
            weather: .foggy,
            temperature: Temperature(min: 15, max: 25),
            latitude: 13.0827,
            longitude: 80.2707
        ),

        Location(
            name: "Hyderabad",
            weather: .snowy,
            temperature: Temperature(min: 10, max: 20),
            latitude: 17.3850,
            longitude: 78.4867
        )
    ]

    var filteredLocations: [Location] {
        if searchText.isEmpty {
            return locations
        } else {
            return locations.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

