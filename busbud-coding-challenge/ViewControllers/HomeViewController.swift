//
//  HomeViewController.swift
//  busbud-coding-challenge
//
//  Created by Spencer Diniz on 17/12/24.
//

import UIKit

class HomeViewController: UIViewController {
    private var stackViewMain: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually

        return stackView
    }()

    private var stackViewButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually

        return stackView
    }()

    private var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose implmentation:"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)

        return label
    }()

    private var buttonUIKit: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("UIKit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 22.0
        button.layer.masksToBounds = true

        return button
    }()

    private var buttonSwiftUI: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SwiftUI", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 22.0
        button.layer.masksToBounds = true

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(stackViewMain)

        NSLayoutConstraint.activate([
            stackViewMain.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewMain.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonUIKit.heightAnchor.constraint(equalToConstant: 44),
            buttonUIKit.widthAnchor.constraint(equalToConstant: 120),
            buttonSwiftUI.heightAnchor.constraint(equalToConstant: 44),
            buttonSwiftUI.widthAnchor.constraint(equalToConstant: 120),
        ])

        stackViewMain.addArrangedSubview(labelTitle)
        stackViewMain.addArrangedSubview(stackViewButtons)
        stackViewButtons.addArrangedSubview(buttonUIKit)
        stackViewButtons.addArrangedSubview(buttonSwiftUI)

        buttonUIKit.addTarget(self, action: #selector(startUIKitDemo), for: .touchUpInside)
        buttonSwiftUI.addTarget(self, action: #selector(startSwiftUIDemo), for: .touchUpInside)
    }

    @objc private func startUIKitDemo() {
        let suggestionsViewController = SuggestionsListViewController()
        navigationController?.pushViewController(suggestionsViewController, animated: true)
    }

    @objc private func startSwiftUIDemo() {
        print("SwiftUI Demo")
    }
}
