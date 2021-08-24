//
//  WeatherAPI.swift
//  NextUp
//
//  Created by Nate Koch on 8/14/21.
//
//  based on: https://www.globalnerdy.com/2016/04/02/how-to-build-an-ios-weather-app-in-swift-part-1-a-very-bare-bones-weather-app/
//

import Foundation
import CoreLocation

class WeatherAPI {
      
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "" // invalidated old one since accidentally pushed key
      
    func getWeather(lat: String, lon: String) {
        let session = URLSession.shared
        
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?lat=\(lat)&lon=\(lon)&appid=\(openWeatherMapAPIKey)")!
        
        let dataTask = session.dataTask(with: weatherRequestURL) {
              (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error)
            }
            else {
                do {
                    let weather = try JSONSerialization.jsonObject(with:
                    data!,
                    options: .mutableContainers) as! [String: AnyObject]
                    print("Temperature: \(weather["main"]!["temp"]!!)")
                }
                catch let jsonError as NSError {
                    print(jsonError.description)
                }
            }
        }
        dataTask.resume()
    }
}
