//
//  PlacesController.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 02/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit

class PlacesController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let searchController = UISearchController(searchResultsController: nil)
    
    let model: [PlaceModel] = [PlaceModel(colorScheme: UIColor.zagrebColors, name: "Zagreb", currentTemp: "21", highestTemp: "24", lowestTemp: "11"),
                               PlaceModel(colorScheme: UIColor.rijekaColors, name: "Rijeka", currentTemp: "29", highestTemp: "31", lowestTemp: "19"),
                               PlaceModel(colorScheme: UIColor.splitColors, name: "Split", currentTemp: "28", highestTemp: "28", lowestTemp: "16"),
                               PlaceModel(colorScheme: UIColor.osijekColors, name: "Osijek", currentTemp: "17", highestTemp: "18", lowestTemp: "9")]
    
    var filteredModel: [PlaceModel] = []
    
    public var delegate: PlacesCoordinator?
    
    convenience init () {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(PlacesCell.self, forCellWithReuseIdentifier: PlacesCell.identifier)
        
        
        let session = URLSession.shared
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?id=3186886&APPID=1604c2075a5c4e14532ade8775983ed9&units=metric")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let networkResponse = try JSONDecoder().decode(NetworkResponse.self, from: data)
                print(networkResponse)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        })
        
        task.resume()
        
        setupViews()
        setupNavigationBar()
        setupSearch()
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
        if isFiltering  {
            delegate?.didSelect(model: filteredModel[indexPath.row])
        } else {
            delegate?.didSelect(model: model[indexPath.row])
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlacesCell.identifier, for: indexPath) as? PlacesCell else {
            fatalError()
        }
        
        if isFiltering {
            cell.setupCell(placesModel: filteredModel[indexPath.row])
        } else {
            cell.setupCell(placesModel: model[indexPath.row])
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredModel.count
        }
        
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        return CGSize(width: view.frame.width - 40.0, height: 180)
        return CGSize(width: view.frame.width, height: 180)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 15.0, right: 0.0)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredModel = model.filter { (place: PlaceModel) -> Bool in
            return place.name.lowercased().contains(searchText.lowercased())
        }
        
        self.collectionView.reloadData()
    }
}

extension PlacesController: UISearchResultsUpdating {
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
