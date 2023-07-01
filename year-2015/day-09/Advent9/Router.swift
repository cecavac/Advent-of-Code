//
//  Router.swift
//  Advent9
//
//  Created by Dragan Cecavac on 22.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Router {
    struct Route {
        var origin: String
        var destination: String
        var distance: Int
    }

    var routes: [Route] = []
    var cities: Set<String> = Set()

    init(for input: String) {
        let lines = input.split(separator: "\n")

        for line in lines {
            let data = line.split(separator: " ")

            let origin = String(data[0])
            let destination = String(data[2])

            if let distance = Int(data[4]) {
                let route = Route(origin: origin, destination: destination, distance: distance)
                routes += [route]
                cities.insert(origin)
                cities.insert(destination)
            }
        }
    }

    private func calculateDistance(_ visitedCitiesOriginal: Set<String>, from currentCity: String, minimize minimization: Bool) -> Int {
        var bestDistance: Int;

        if (minimization) {
            bestDistance = Int.max
        } else {
            bestDistance = Int.min
        }

        if (visitedCitiesOriginal.count == cities.count) {
            return 0
        }

        for city in cities {
            var visitedCities = visitedCitiesOriginal
            var cityDistance = Int.max
            var foundNextCity = false

            if visitedCities.contains(city) {
                continue
            }

            for route in routes {
                if (route.origin == city && route.destination == currentCity) ||
                    (route.origin == currentCity && route.destination == city) {
                    cityDistance = route.distance
                    foundNextCity = true
                    break
                }
            }

            if (!foundNextCity) {
                print("Didn't find the next city error")
                return cityDistance
            }

            visitedCities.insert(city)
            var currentDistance = calculateDistance(visitedCities, from: city, minimize: minimization)
            currentDistance += cityDistance

            if (minimization) {
                bestDistance = min(bestDistance, currentDistance)
            } else {
                bestDistance = max(bestDistance, currentDistance)
            }
        }

        return bestDistance
    }

    public func calculateDistance(minimize minimization: Bool) -> Int {
        var bestDistance: Int;

        if (minimization) {
            bestDistance = Int.max
        } else {
            bestDistance = Int.min
        }

        for city in cities {
            var visitedCities: Set<String> = Set();
            visitedCities.insert(city)

            let distance = calculateDistance(visitedCities, from: city, minimize: minimization)
            if (minimization) {
                bestDistance = min(bestDistance, distance)
            } else {
                bestDistance = max(bestDistance, distance)
            }
        }

        return bestDistance
    }
}
