import Foundation

struct WeatherResponse: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let currentUnits: CurrentUnits
    let current: Current

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
    }
}

struct Current: Codable {
    let time: String
    let interval: Int

    
    let temperature2M: Double

    
    let relativeHumidity2M: Int
    let surfacePressure: Double
    let windSpeed80M: Double
    let visibility: Double
    let precipitation: Double
    let soilTemperature6CM: Double

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case surfacePressure = "surface_pressure"
        case windSpeed80M = "wind_speed_80m"
        case visibility
        case precipitation
        case soilTemperature6CM = "soil_temperature_6cm"
    }
}

struct CurrentUnits: Codable {
    let time, interval, temperature2M: String

    let relativeHumidity2M: String
    let surfacePressure: String
    let windSpeed80M: String
    let visibility: String
    let precipitation: String
    let soilTemperature6CM: String

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case surfacePressure = "surface_pressure"
        case windSpeed80M = "wind_speed_80m"
        case visibility
        case precipitation
        case soilTemperature6CM = "soil_temperature_6cm"
    }
}

