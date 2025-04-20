//
//  ViewController.swift
//  miniproject2
//
//  Created by Stephano Portella on 03/04/25.
//
import UIKit

class ViewController: UIViewController {

    private let morphView = MorphingView()
    private let shapeButtons = ["Square", "Rectangle", "Diamond", "Circle", "Heart", "Star"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        morphView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(morphView)

        NSLayoutConstraint.activate([
            morphView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            morphView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            morphView.widthAnchor.constraint(equalToConstant: 300),
            morphView.heightAnchor.constraint(equalToConstant: 300)
        ])

        setupButtons()
        morphView.startMorphing()
    }

    private func setupButtons() {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false

        for (index, title) in shapeButtons.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(changeShape(_:)), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func changeShape(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            morphView.setTargetShape(.square)
        case 1:
            morphView.setTargetShape(.rectangle)
        case 2:
            morphView.setTargetShape(.diamond)
        case 3:
            morphView.setTargetShape(.circle)
        case 4:
            morphView.setTargetShape(.heart)
        case 5:
            morphView.setTargetShape(.star)
        default:
            break
        }
    }
}
