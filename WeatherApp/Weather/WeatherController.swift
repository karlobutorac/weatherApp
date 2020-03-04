//
//  WeatherController.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 02/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import UIKit

class WeatherController: UIViewController {
    public weak var delegate: WeatherCoordinator?
    public var model: PlaceModel!
    
    convenience init(model: PlaceModel) {
        self.init(nibName: nil, bundle: nil)
        
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupContent()
    }
    
    @objc private func dismissButtonClicked() {
        delegate?.dismiss()
    }
    
    private func setupContent() {
        view.layer.configureGradientBackground(colors: model.colorScheme)
        
        self.nameLabel.text = model.name
        self.currentTempLabel.text = "\(model.currentTemp)°"
        self.highestTempLabel.text = "\(model.highestTemp)°"
        self.lowestTempLabel.text = "\(model.lowestTemp)°"
        
        dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
    }
    
    private func setupViews() {
        view.addSubview(nameLabel)
        view.addSubview(currentTempLabel)
        view.addSubview(highestTempLabel)
        view.addSubview(lowestTempLabel)
        view.addSubview(highestLowestSeparatorView)
        view.addSubview(dismissButton)
        view.addSubview(detailsLabel)
        view.addSubview(detailsView)
        view.addSubview(detailCollectionView.collectionView)
        
        
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        dismissButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        currentTempLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        currentTempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        lowestTempLabel.bottomAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: -20).isActive = true
        lowestTempLabel.leftAnchor.constraint(equalTo: currentTempLabel.rightAnchor, constant: 20).isActive = true
        
        highestLowestSeparatorView.bottomAnchor.constraint(equalTo: lowestTempLabel.topAnchor, constant: -5).isActive = true
        highestLowestSeparatorView.leftAnchor.constraint(equalTo: lowestTempLabel.leftAnchor, constant: 0).isActive = true
        highestLowestSeparatorView.rightAnchor.constraint(equalTo: lowestTempLabel.rightAnchor, constant: 0).isActive = true
        highestLowestSeparatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        highestTempLabel.bottomAnchor.constraint(equalTo: highestLowestSeparatorView.topAnchor, constant: -5).isActive = true
        highestTempLabel.leftAnchor.constraint(equalTo: currentTempLabel.rightAnchor, constant: 20).isActive = true
        
        detailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        detailsLabel.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: 20).isActive = true
        
        detailsView.leftAnchor.constraint(equalTo: detailsLabel.rightAnchor, constant: 20).isActive = true
        detailsView.centerYAnchor.constraint(equalTo: detailsLabel.centerYAnchor, constant: 0).isActive = true
        detailsView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        detailsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        detailCollectionView.collectionView.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 20).isActive = true
        detailCollectionView.collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        detailCollectionView.collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        detailCollectionView.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true

    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 40, weight: .thin)
        label.textColor = .white
        return label
    }()
    
    let currentTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 90, weight: .ultraLight)
        label.textColor = .white
        return label
    }()
    
    let highestTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 25, weight: .thin)
        label.textColor = .white
        return label
    }()
    
    let lowestTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 25, weight: .thin)
        label.textColor = .white
        return label
    }()
    
    let highestLowestSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        return view
    }()
    
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.init(named: "close.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "DETAILS"
        return label
    }()
    
    let detailsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 1
        return view
    }()
    
    let detailCollectionView: DetailsCollectionViewController = {
        let cv = DetailsCollectionViewController()
        cv.collectionView.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
}
