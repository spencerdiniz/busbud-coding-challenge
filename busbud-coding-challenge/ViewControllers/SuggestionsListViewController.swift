//
//  SuggestionsViewController.swift
//  busbud-coding-challenge
//
//  Created by Spencer Diniz on 17/12/24.
//

import UIKit

class SuggestionsListViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Suggestions"
        view.backgroundColor = .white

        Task {
            await loadData()
        }

        print("VIEW DID LOAD ")
    }

    private func loadData() async {
        let suggestions = try? await BusbudService.shared.fetchSuggestions()

        DispatchQueue.main.async {
            print(suggestions ?? [])
        }
    }
}
