//
//  DetailsCell.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 04/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//


import UIKit

class DetailsCell: UICollectionViewCell {
    static let identifier = "DetailsCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(detailsModel: DetailsModel) {
        image.image = detailsModel.image.withRenderingMode(.alwaysTemplate)
        titleLabel.text = detailsModel.title
        valueLabel.text = detailsModel.value
    }
    
    private func setupViews() {
        setupCellCorners()
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        addSubview(image)
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        image.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 35).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1.0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        valueLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        valueLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    
    private func setupCellCorners() {
        self.layer.cornerRadius = 10
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = true
    }
    
    
    let image: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white.withAlphaComponent(0.85)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.textColor = .white
        return label
    }()
}
