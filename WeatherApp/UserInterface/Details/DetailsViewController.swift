//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 03/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsCollectionViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var datasource: Datasource!
    var cityId: Int!
    var detailsListViewModel: DetailsListViewModel!
    
    convenience init (datasource: Datasource, cityId: Int, forecast: Forecast) {
        self.init()
        
        self.datasource = datasource
        self.cityId = cityId
        self.detailsListViewModel = DetailsListViewModel(datasource: datasource, cityId: cityId, forecast: forecast)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: DetailsCell.identifier)
                
        detailsListViewModel.details.asObservable().bind(to: collectionView.rx.items(cellIdentifier: DetailsCell.identifier, cellType: DetailsCell.self)) { row, details, cell in
            cell.setupCell(detailsModel: DetailsCellViewModel(details: details))
        }.disposed(by: disposeBag)
        
        setupViews()
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    let collectionView: UICollectionView =  {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
}
