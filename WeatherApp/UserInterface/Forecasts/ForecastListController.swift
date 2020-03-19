//
//  ForecastListController.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 02/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class ForecastListController: UIViewController {
    let searchController = UISearchController(searchResultsController: nil)
    let disposeBag = DisposeBag()
    
    var forecastListViewModel: ForecastListViewModel!
    var datasource: Datasource!
    var delegate: ForecastsCoordinator!
    
    convenience init (datasource: Datasource) {
        self.init()
        
        self.datasource = datasource
        self.forecastListViewModel = ForecastListViewModel(datasource: datasource)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViews()
        setupNavigationBar()
        setupSearchBar()
    }
    
    private func setupViews() {
        self.view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func bindViews() {
        collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: ForecastCell.identifier)
        collectionView.delegate = self
        
        let results = searchController.searchBar.rx.text.orEmpty
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[Forecast]> in
                if query.isEmpty {
                    return self.forecastListViewModel.forecasts.asObservable()
                }
                
                return self.forecastListViewModel.forecasts.asObservable().flatMap { forecasts -> Observable<[Forecast]> in
                    return .just(
                        forecasts.filter { return $0.name.lowercased().contains(query.lowercased())})
                }
        }.observeOn(MainScheduler.instance)
        
        results.bind(to: collectionView.rx.items(cellIdentifier: ForecastCell.identifier, cellType: ForecastCell.self)) { row, forecast, cell in
            cell.setupCell(forecastCellViewModel: ForecastCellViewModel(forecast: forecast))
        }.disposed(by: disposeBag)
        
        
        let tappedForecast = Observable.combineLatest(results, collectionView.rx.itemSelected)
        
        collectionView.rx
            .itemSelected
            .withLatestFrom(tappedForecast)
            .subscribe({ event in
                guard let indexPath = event.element?.1, let forecasts = event.element?.0  else {
                    return
                }
                
                if indexPath.row >= forecasts.count {
                    return
                }
                
                let forecastCellViewModel = ForecastCellViewModel.init(forecast: forecasts[indexPath.row])
                
                self.animateTransition(for: indexPath, forecastCellViewModel: forecastCellViewModel) { _ in
                    self.delegate?.didSelect(model: forecasts[indexPath.row])
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupNavigationBar()  {
        navigationItem.title = "Weather App"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23, weight: .ultraLight)]
    }
    
     private func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"
        searchController.searchBar.tintColor = .black
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    let collectionView: UICollectionView =  {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        return cv
    }()
}
