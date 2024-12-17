//
//  BusbudService.swift
//  busbud-coding-challenge
//
//  Created by Spencer Diniz on 17/12/24.
//

import Foundation

public class BusbudService {
    public static let shared = BusbudService()

    func fetchSuggestions() async throws -> [Suggestion] {
        let url = URL(string: "https://napi.busbud.com/flex/suggestions/points-of-interest")!
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.httpMethod = "GET"
        request.addValue("application/vnd.busbud+json; version=3; profile=https://schema.busbud.com/v3/anything.json", forHTTPHeaderField: "Accept")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            //TODO: Check response codes and handle accordingly.
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                throw URLError(.badServerResponse)
            }

            let decoder = JSONDecoder()
            let suggestionResponse = try decoder.decode(SuggestionsResponse.self, from: data)
            return suggestionResponse.suggestions
        } catch {
            print("Failed to fetch suggestions: \(error)")
            throw error
        }
    }
}
