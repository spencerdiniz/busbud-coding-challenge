//
//  SuggestionDetailViewController.swift
//  busbud-coding-challenge
//
//  Created by Spencer Diniz on 17/12/24.
//

import UIKit
import MapKit

class SuggestionDetailViewController: UIViewController {
    let scrollViewMain: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true

        return scrollView
    }()

    let stackViewMain: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0.0
        stackView.distribution = .fill

        return stackView
    }()

    let labelCity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "City"
        label.textColor = .secondaryLabel

        return label
    }()

    let labelCityValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label

        return label
    }()

    let labelRegion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "State / Province / Region"
        label.textColor = .secondaryLabel

        return label
    }()

    let labelRegionValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label

        return label
    }()

    let labelCountry: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "Country"
        label.textColor = .secondaryLabel

        return label
    }()

    let labelCountryValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label

        return label
    }()

    let labelDistance: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "Distance"
        label.textColor = .secondaryLabel

        return label
    }()

    let labelDistanceValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label

        return label
    }()

    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        mapView.clipsToBounds = true
        mapView.layer.cornerRadius = 4
        mapView.layer.masksToBounds = true
        mapView.layer.borderWidth = 1
        mapView.layer.borderColor = UIColor.opaqueSeparator.cgColor

        return mapView
    }()

    let buttonGoToWebsite: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go to Busbud Website", for: .normal)
        button.setTitleColor(.lightText, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 4.0
        button.layer.masksToBounds = true

        return button
    }()

    let suggestion: Suggestion

    init(suggestion: Suggestion) {
        self.suggestion = suggestion

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Details"
        navigationItem.backButtonTitle = ""

        setupUI()
        loadInfo()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollViewMain)
        scrollViewMain.addSubview(stackViewMain)

        stackViewMain.addArrangedSubview(labelCity)
        stackViewMain.addArrangedSubview(labelCityValue)
        stackViewMain.addArrangedSubview(labelRegion)
        stackViewMain.addArrangedSubview(labelRegionValue)
        stackViewMain.addArrangedSubview(labelCountry)
        stackViewMain.addArrangedSubview(labelCountryValue)
        stackViewMain.addArrangedSubview(labelDistance)
        stackViewMain.addArrangedSubview(labelDistanceValue)
        stackViewMain.addArrangedSubview(mapView)
        stackViewMain.addArrangedSubview(buttonGoToWebsite)

        stackViewMain.setCustomSpacing(14.0, after: labelCityValue)
        stackViewMain.setCustomSpacing(14.0, after: labelRegionValue)
        stackViewMain.setCustomSpacing(14.0, after: labelCountryValue)
        stackViewMain.setCustomSpacing(14.0, after: labelDistanceValue)
        stackViewMain.setCustomSpacing(14.0, after: mapView)

        NSLayoutConstraint.activate([
            scrollViewMain.topAnchor.constraint(equalTo: view.topAnchor),
            scrollViewMain.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollViewMain.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollViewMain.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackViewMain.topAnchor.constraint(equalTo: scrollViewMain.topAnchor),
            stackViewMain.bottomAnchor.constraint(equalTo: scrollViewMain.bottomAnchor),
            stackViewMain.leadingAnchor.constraint(equalTo: scrollViewMain.leadingAnchor, constant: 20.0),
            stackViewMain.trailingAnchor.constraint(equalTo: scrollViewMain.trailingAnchor, constant: -20.0),
            stackViewMain.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40.0),
            mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor),
            buttonGoToWebsite.heightAnchor.constraint(equalToConstant: 44.0),
        ])

        buttonGoToWebsite.addTarget(self, action: #selector(goToWebsite), for: .touchUpInside)
    }

    private func loadInfo() {
        labelCityValue.text = suggestion.cityName
        labelRegionValue.text = suggestion.regionName
        labelCountryValue.text = suggestion.countryName
        labelDistanceValue.text = suggestion.formattedDistance
        centerMapOnLocation()
    }

    private func centerMapOnLocation() {
        let coordinate = CLLocationCoordinate2D(latitude: suggestion.lat, longitude: suggestion.lon)

        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = suggestion.cityName

        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }

    @objc private func goToWebsite() {
        guard let url = URL(string: "https://www.busbud.com/en/c/\(suggestion.geohash)") else {
            return
        }

        UIApplication.shared.open(url)
    }
}
