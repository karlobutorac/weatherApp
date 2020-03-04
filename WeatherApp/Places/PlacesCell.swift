//
//  PlacesCell.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 03/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit

class PlacesCell: UICollectionViewCell {
    static let identifier = "PlacesCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(placesModel: PlaceModel) {
        self.layer.configureGradientBackground(colors: placesModel.colorScheme)
        
        self.nameLabel.text = placesModel.name
        self.currentTempLabel.text = "\(placesModel.currentTemp)°"
        self.highestTempLabel.text = "\(placesModel.highestTemp)°"
        self.lowestTempLabel.text = "\(placesModel.lowestTemp)°"
    }
    
    func setupViews(){
        setupCellCorners()
        
        addSubview(nameLabel)
        addSubview(currentTempLabel)
        addSubview(highestTempLabel)
        addSubview(lowestTempLabel)
        addSubview(highestLowestSeparatorView)
        
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
//        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        currentTempLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        currentTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
//        currentTempLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        
        lowestTempLabel.bottomAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: -20).isActive = true
        lowestTempLabel.leftAnchor.constraint(equalTo: currentTempLabel.rightAnchor, constant: 20).isActive = true
        
        highestLowestSeparatorView.bottomAnchor.constraint(equalTo: lowestTempLabel.topAnchor, constant: -5).isActive = true
        highestLowestSeparatorView.leftAnchor.constraint(equalTo: lowestTempLabel.leftAnchor, constant: 0).isActive = true
        highestLowestSeparatorView.rightAnchor.constraint(equalTo: lowestTempLabel.rightAnchor, constant: 0).isActive = true
        highestLowestSeparatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        highestTempLabel.bottomAnchor.constraint(equalTo: highestLowestSeparatorView.topAnchor, constant: -5).isActive = true
        highestTempLabel.leftAnchor.constraint(equalTo: currentTempLabel.rightAnchor, constant: 20).isActive = true
    }
    
    private func setupCellCorners() {
        self.layer.cornerRadius = 0
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = true
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
    
    
}
