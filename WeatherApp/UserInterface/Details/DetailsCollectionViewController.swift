//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 03/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit

struct Details {
    var title: String
    var value: String
    var image: String?
}

class DetailsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var model: [Details]!
    
    convenience init (forecast: Forecast) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        
        
        initializeModel(from: forecast)
    }
    
    
    private func initializeModel(from forecast: Forecast) {
        model = [Details]()
        
        model.append(Details(title: "Feels like", value: "\(forecast.feelsLike)°", image: AssetHelper.tempImageName))
        model.append(Details(title: "Wind", value: "\(forecast.wind)km/h", image: AssetHelper.windImageName))
        model.append(Details(title: "Humidity", value: "\(forecast.humidity)%", image: AssetHelper.humidityImageName))
        model.append(Details(title: "Pressure", value: "\(forecast.pressure)", image: AssetHelper.pressureImageName))
        model.append(Details(title: "visibility", value:"\(forecast.visibility)", image: AssetHelper.visibilityImageName))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: DetailsCell.identifier)
        
        setupViews()
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .clear
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCell.identifier, for: indexPath) as? DetailsCell else {
            fatalError()
        }
        
        cell.setupCell(detailsModel: model[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 30) / 3.0, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
