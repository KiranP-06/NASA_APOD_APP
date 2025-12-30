//
//  APIService.swift
//  NASA_APOD_APP
//
//  Created by admin34 on 30/12/25.
//

import Foundation


enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
}

class APIService {

    private let baseURL = "https://api.nasa.gov/planetary/apod"
    private let apiKey = "V8DOG1ThhVYFY8cWSmW0wBs2WNkV02h4jdJX2ILf"

    func fetchAPOD(date: Date? = nil) async throws -> APODItem {
        var components = URLComponents(string: baseURL)
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
       
        if let date = date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: date)
            queryItems.append(URLQueryItem(name: "date", value: dateString))
        }
        
        components?.queryItems = queryItems
        
        guard let url = components?.url else { throw APIError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        do {
            let apod = try JSONDecoder().decode(APODItem.self, from: data)
            return apod
        } catch {
            throw APIError.decodingError
        }
    }
}
