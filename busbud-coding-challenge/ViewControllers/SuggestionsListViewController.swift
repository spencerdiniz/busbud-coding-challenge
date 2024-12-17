//
//  SuggestionsViewController.swift
//  busbud-coding-challenge
//
//  Created by Spencer Diniz on 17/12/24.
//

import UIKit
import CoreLocation

class SuggestionsListViewController: UITableViewController {
    private var suggestions: [Suggestion] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Suggestions"

        Task {
            do {
                let locationService = LocationService()
                let coordinate = try await locationService.requestLocation()
                await loadData(for: coordinate)
            } catch {
                print("Failed to get location: \(error.localizedDescription)")
            }
        }
    }

    private func setupUI() {
        view.backgroundColor = .white
        tableView.separatorInset = .zero
    }

    private func loadData(for coordinate: CLLocationCoordinate2D) async {
        let suggestions = try? await BusbudService.shared.fetchSuggestions(for: coordinate)

        DispatchQueue.main.async {
            self.suggestions = suggestions ?? []
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let suggestion = suggestions[indexPath.row]

        cell.textLabel?.text = suggestion.cityName
        cell.detailTextLabel?.text = "\(suggestion.formattedDistanceInKm) / \(suggestion.formattedDistanceInMiles)"
        cell.accessoryType = .disclosureIndicator
        cell.separatorInset = .zero
        cell.selectionStyle = .none

        return cell
    }
}
