import Foundation
import SwiftUI

enum WeatherType {
    case sunny
    case foggy
    case snowy
    case rainy
    case windy

    var iconName: String {
        switch self {
        case .sunny: return "sun.max.fill"
        case .foggy: return "cloud.fog.fill"
        case .snowy: return "snowflake"
        case .rainy: return "cloud.rain.fill"
        case .windy: return "wind"
        }
    }
}

struct Temperature {
    let min: Int
    let max: Int

    var temperatureText: String {
        "\(min) °C / \(max) °C"
    }
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let weather: WeatherType
    let temperature: Temperature
    let latitude: Double
    let longitude: Double
}

