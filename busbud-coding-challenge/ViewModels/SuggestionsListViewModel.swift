//
//  SuggestionsListViewModel.swift
//  busbud-coding-challenge
//
//  Created by Spencer Diniz on 17/12/24.
//

import Foundation
import CoreLocation

@MainActor
class SuggestionsListViewModel {
    var suggestions: [Suggestion] = []

    func loadData(for coordinate: CLLocationCoordinate2D) async {
        let fetchedSuggestions = try? await BusbudService.shared.fetchSuggestions(for: coordinate)
        suggestions = fetchedSuggestions ?? []
    }
}
