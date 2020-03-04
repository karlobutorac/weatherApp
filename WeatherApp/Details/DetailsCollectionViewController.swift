//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 03/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit


class DetailsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let model: [DetailsModel] = [DetailsModel(image: UIImage.init(named: "temp")!, title: "Feels like", value: " 22°"),
                                 DetailsModel(image: UIImage.init(named: "eye")!, title: "Visability", value: " 10 km"),
                                 DetailsModel(image: UIImage.init(named: "meter")!, title: "Pressure", value: "1011"),
                                 DetailsModel(image: UIImage.init(named: "humidity")!, title: "Humidity", value: "25 %"),
                                 DetailsModel(image: UIImage.init(named: "wind")!, title: "Wind", value: " 2 km/h")]
    
    
    convenience init () {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
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
