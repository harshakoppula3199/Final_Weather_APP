//
//  WeatherRequest.swift
//  weatherapp
//
//  Created by rentamac on 1/26/26.
//
import Foundation  

struct WeatherRequest {
    let latitude: Double
    let longitude: Double
}

struct WeatherEndpoint: APIEndpoint {

    let request: WeatherRequest

    var baseURL: String {
        "https://api.broken-url.com"
//        "https://api.open-meteo.com"

        
    }

    var path: String {
        "/v1/forecast"
    }

    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "latitude", value: "\(request.latitude)"),
            URLQueryItem(name: "longitude", value: "\(request.longitude)"),
            URLQueryItem(name: "current", value: "temperature_2m,relative_humidity_2m,surface_pressure,wind_speed_80m,visibility,precipitation,soil_temperature_6cm"
                     )
        ]
    }
}
