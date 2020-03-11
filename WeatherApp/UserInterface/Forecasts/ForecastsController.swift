//
//  ForecastsController.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 02/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit

class ForecastsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let searchController = UISearchController(searchResultsController: nil)
    
    var model: [Forecast] = []
    var filteredModel: [Forecast] = []
    
    var datasource: Datasource!
    
    public var delegate: ForecastsCoordinator?
    
    convenience init (datasource: Datasource) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.datasource = datasource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ForecastsCell.self, forCellWithReuseIdentifier: ForecastsCell.identifier)
        collectionView.alwaysBounceVertical = true
        
        setupViews()
        setupNavigationBar()
        setupSearch()
        setupData()
    }
    
    private func setupData() {
        
        datasource.getAllWeatherForecasts() { (result) in
            switch result {
            case .success(let forecasts):
                self.model = forecasts
                self.collectionView.reloadData()
            case .failure(let error):
                print("Failed to query weather forecasts with error: \(error)")
            }
        }
    }
    
    private func setupNavigationBar()  {
        navigationItem.title = "Weather App"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23, weight: .ultraLight)]
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .white
    }
    
    // MARK: CollectionViewController
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchController.searchBar.endEditing(true)
        
        animateTransition(for: indexPath) { _ in
            if self.isFiltering {
                self.delegate?.didSelect(model: self.filteredModel[indexPath.row])
            } else {
                self.delegate?.didSelect(model: self.model[indexPath.row])
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastsCell.identifier, for: indexPath) as? ForecastsCell else {
            fatalError()
        }
        
        cell.setupCell(forecastsModel: isFiltering ? filteredModel[indexPath.row] : model[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredModel.count
        }
        
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 15.0, right: 0.0)
    }
}
