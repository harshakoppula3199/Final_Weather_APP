import SwiftUI
import Combine
import CoreData

@MainActor
final class WeatherViewModel: ObservableObject {

    private let context =
        PersistenceController.shared.container.viewContext

    @Published var temperature: String = "--"
    @Published var description: String = ""

    @Published var humidity: String = "--"
    @Published var pressure: String = "--"
    @Published var windSpeed: String = "--"
    @Published var visibility: String = "--"
    @Published var precipitation: String = "--"
    @Published var soilTemperature: String = "--"

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol

    init() {
        let networkService = HttpNetworking()
        self.weatherService = WeatherService(networkService: networkService)
    }

    func loadWeather(
        latitude: Double,
        longitude: Double,
        cityName: String
    ) async {
        isLoading = true
        errorMessage = nil

        print(" API call for:", cityName)

        do {
            let response = try await weatherService.fetchWeather(
                latitude: latitude,
                longitude: longitude
            )

            temperature =
                "\(response.current.temperature2M) \(response.currentUnits.temperature2M)"

            humidity =
                "\(response.current.relativeHumidity2M) \(response.currentUnits.relativeHumidity2M)"

            windSpeed =
                "\(response.current.windSpeed80M) \(response.currentUnits.windSpeed80M)"

            print("API Success:", cityName, temperature, humidity, windSpeed)

            
            saveWeatherToCache(
                cityName: cityName,
                temperature: temperature,
                humidity: humidity,
                windSpeed: windSpeed
            )

            isLoading = false

        } catch {
            print("API failed for:", cityName)

            let cacheLoaded = loadCachedWeather(for: cityName)

            if !cacheLoaded {
                errorMessage = "Unable to fetch weather"
                print("No cached data for:", cityName)
            } else {
                errorMessage = nil
                print("Loaded cached data for:", cityName)
            }

            isLoading = false
        }
    }

    private func saveWeatherToCache(
        cityName: String,
        temperature: String,
        humidity: String,
        windSpeed: String
    ) {
        let weather = WeatherEntity(context: context)

        weather.cityName = cityName
        weather.temperature = temperature
        weather.humidity = humidity
        weather.windSpeed = windSpeed

        do {
            try context.save()
            print("Saved to Core Data:", cityName)
        } catch {
            print("Core Data save failed:", error)
        }
    }
    
    
    func clearWeatherCache() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> =
            WeatherEntity.fetchRequest()

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()

           
            temperature = "--"
            humidity = "--"
            windSpeed = "--"

            errorMessage = nil

            print("Core Data cache cleared successfully")

        } catch {
            print("Failed to clear Core Data cache:", error)
        }
    }


    @discardableResult
    private func loadCachedWeather(for cityName: String) -> Bool {
        let request: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        request.predicate = NSPredicate(
            format: "cityName == %@",
            cityName
        )
        request.fetchLimit = 1

        do {
            if let cached = try context.fetch(request).first {
                temperature = cached.temperature ?? "--"
                humidity = cached.humidity ?? "--"
                windSpeed = cached.windSpeed ?? "--"

                print("Cache found for:", cityName)
                return true
            }
        } catch {
            print("Core Data fetch failed:", error)
        }

        return false
    }
}

