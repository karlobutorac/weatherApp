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
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    @objc private func addButtonClicked() {
        print("Add Button clicked")
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .white
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"
        searchController.searchBar.tintColor = .black
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
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
    
    private func animateTransition(for indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            debugPrint("Cell for index path \(indexPath) does not exist")
            return
        }
        cell.isHidden = true
        
        let cellCopy = ForecastsCell(frame: cell.frame)
        let forecast = self.isFiltering ? self.filteredModel[indexPath.row] : self.model[indexPath.row]
        
        let shrinkedFrame = CGRect(x: cellCopy.frame.minX + 5 , y: cellCopy.frame.minY + 5, width: cellCopy.frame.width - 10 , height: cellCopy.frame.height - 10)
        let transitionFrame = CGRect(x: cellCopy.frame.minX, y: cellCopy.frame.minY + (self.navigationController?.viewControllers[0].view.frame.minY)!, width: cellCopy.frame.width, height: cellCopy.frame.height)
        let expandedFrame = CGRect(x: 0 , y: 0, width: self.navigationController!.view.frame.width , height: self.navigationController!.view.frame.height)
        
        self.animateTransition(of: cellCopy, with: forecast, to: shrinkedFrame, inside: collectionView, duration: 0.2) { _ in
            
            if cellCopy.hasTopNotch {
                cellCopy.nameLabelTopAchor?.constant = CGFloat(Int(cellCopy.nameLabelTopAchor!.constant) +  24) //magic number treba rjesit
            }
            
            self.animateTransition(of: cellCopy, with: forecast,from: transitionFrame, to: expandedFrame, inside: self.navigationController!.view, duration: 0.5, usingSpringWithDamping: 1.0, completion: {  bool in
                completion(bool)
                
                DispatchQueue.main.async {
                    cell.isHidden = false
                    cellCopy.removeFromSuperview()
                }
            })
        }
    }
    
    func animateTransition(of cell: ForecastsCell, with forecast: Forecast, from fromFrame: CGRect? = nil, to toFrame: CGRect, inside view: UIView, duration: Double, usingSpringWithDamping: CGFloat = 1.0, completion: @escaping (Bool) -> Void) {
        if let fromFrame = fromFrame{
            cell.frame = fromFrame
        }
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            cell.removeFromSuperview()
            view.addSubview(cell)
            cell.frame = toFrame
            view.layoutSubviews()
            cell.setupCell(forecastsModel: forecast)
        }, completion: completion)
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
    
    func filterContentForSearchText(_ searchText: String) {
        filteredModel = model.filter { (place: Forecast) -> Bool in
            return place.name.lowercased().contains(searchText.lowercased())
        }
        
        self.collectionView.reloadData()
    }
}

extension ForecastsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
}
