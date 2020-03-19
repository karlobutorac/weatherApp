//
//  ForecastsCell.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 03/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ForecastCell: UICollectionViewCell {
    static let identifier = "ForecastsCellId"
    var nameLabelTopAchor: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCell(forecastCellViewModel: ForecastCellViewModel) {
        self.layer.configureGradientBackground(colors: forecastCellViewModel.colorScheme)
        
        self.nameLabel.text = forecastCellViewModel.name
        self.currentTempLabel.text = forecastCellViewModel.currentTemp
        self.maxTempLabel.text = forecastCellViewModel.maxTemp
        self.minTempLabel.text = forecastCellViewModel.minTemp
    }
    
    func setupViews(){
        setupCellCorners()
        
        addSubview(nameLabel)
        addSubview(currentTempLabel)
        addSubview(maxTempLabel)
        addSubview(minTempLabel)
        addSubview(highestLowestSeparatorView)
        
            
        nameLabelTopAchor = nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        nameLabelTopAchor?.isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        
        currentTempLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        currentTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        
        minTempLabel.bottomAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: -20).isActive = true
        minTempLabel.leftAnchor.constraint(equalTo: currentTempLabel.rightAnchor, constant: 20).isActive = true
        
        highestLowestSeparatorView.bottomAnchor.constraint(equalTo: minTempLabel.topAnchor, constant: -5).isActive = true
        highestLowestSeparatorView.leftAnchor.constraint(equalTo: minTempLabel.leftAnchor, constant: 0).isActive = true
        highestLowestSeparatorView.rightAnchor.constraint(equalTo: minTempLabel.rightAnchor, constant: 0).isActive = true
        highestLowestSeparatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        maxTempLabel.bottomAnchor.constraint(equalTo: highestLowestSeparatorView.topAnchor, constant: -5).isActive = true
        maxTempLabel.leftAnchor.constraint(equalTo: currentTempLabel.rightAnchor, constant: 20).isActive = true
    }
    
    private func setupCellCorners() {
        self.layer.cornerRadius = 0
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = true
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40, weight: .thin)
        label.textColor = .white
        return label
    }()
    
    let currentTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 90, weight: .ultraLight)
        label.textColor = .white
        return label
    }()
    
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .thin)
        label.textColor = .white
        return label
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
