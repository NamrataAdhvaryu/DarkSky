//
//  Weather.swift
//  DarkSky
//
//  Created by Namrata Akash on 13/05/21.
//

import Foundation
struct WeatherResponse: Codable {
    let lat: Float
    let lon: Float
    let timezone: String
    let current: CurrentWeather
    let hourly: [HourlyWeatherEntry]
    let daily: [DailyWeather]
    let timezone_offset: Double
}

struct CurrentWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Float
    let feels_like: Float
    let pressure: Int
    let humidity: Int
    let dew_point:Float
    let uvi: Float
    let clouds: Int
    let visibility: Float
    let wind_speed: Float
    let wind_deg: Int
    let weather:[weatherEntry]
}

struct weatherEntry:Codable {
    let id : Int
    let main: String
    let description:String
    let icon:String
}
struct DailyWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moon_phase: Double
    let temp: tempEntry
    let feels_like:feel_likeEntry
    let pressure:Int
    let humidity:Int
    let dew_point:Float
    let wind_speed:Float
    let wind_deg:Int
    let wind_gust:Float
    let weather:[weatherEntry]
    let clouds:Int
    let pop:Float
    let rain:Float?
    let uvi:Float
    
    
    
}
struct tempEntry:Codable {
    let day: Float
    let min: Float
    let max: Float
    let night: Float
    let eve: Float
    let morn: Float
}

struct feel_likeEntry:Codable {
    let day: Float
    let night: Float
    let eve: Float
    let morn: Float
}





struct HourlyWeatherEntry: Codable {
    let dt: Int
    let temp: Float
    let feels_like: Float
    let pressure: Float
    let humidity: Double
    let dew_point: Double
    let uvi: Double
    let clouds: Double
    let visibility: Double
    let wind_speed: Double
    let wind_deg: Double
    let wind_gust: Double
    let weather:[weatherEntry]
    let pop:Float
    
}
