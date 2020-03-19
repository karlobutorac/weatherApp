//
//  ForecastListControllerCollectionView.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 18/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import UIKit

extension ForecastListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastListViewModel.numberOfForecasts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 15.0, right: 0.0)
    }
}

