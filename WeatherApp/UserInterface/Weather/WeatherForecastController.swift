//
//  WeatherForecastController.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 02/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class WeatherForecastController: UIViewController {
    private let disposeBag = DisposeBag()
    public weak var delegate: WeatherCoordinator?
    
    var datasource: Datasource!
    var cityId: Int!
    var forecast: Forecast!
    var weatherForecastViewModel: WeatherForecastViewModel!
    
    convenience init(datasource: Datasource, cityId: Int, forecast: Forecast) {
        self.init(nibName: nil, bundle: nil)
        
        self.datasource = datasource
        self.cityId = cityId
        
        self.weatherForecastViewModel = WeatherForecastViewModel(datasource: datasource, cityId: cityId, forecast: forecast)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dismissButton.fadeIn()
        detailsView.fadeIn()
        detailsLabel.fadeIn()
        detailCollectionView.view.fadeIn()
    }
    
    @objc private func dismissButtonClicked() {
        delegate?.dismiss()
    }
    
    private func bindContent() {
    
        weatherForecastViewModel.colorScheme
            .subscribe { [weak self] colors in
            self?.view.layer.configureGradientBackground(colors: colors.element!)
        }.disposed(by: disposeBag)
        
        weatherForecastViewModel.name
            .asObserver()
            .bind(to: self.nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        weatherForecastViewModel.currentTemp
            .asObservable()
            .bind(to: self.currentTempLabel.rx.text)
            .disposed(by: disposeBag)
        
        weatherForecastViewModel.minTemp
            .asObserver()
            .bind(to: self.minTempLabel.rx.text)
            .disposed(by: disposeBag)
        
        weatherForecastViewModel.maxTemp
            .asObserver()
            .bind(to: self.maxTempLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        dismissButton.rx.tap.bind { [weak self] _ in
            self?.dismissButtonClicked()
        }.disposed(by: disposeBag)
    }
    
    private func setupViews() {
        view.addSubview(nameLabel)
        view.addSubview(currentTempLabel)
        view.addSubview(maxTempLabel)
        view.addSubview(minTempLabel)
        view.addSubview(highestLowestSeparatorView)
        view.addSubview(dismissButton)
        view.addSubview(detailsLabel)
        view.addSubview(detailsView)
        view.addSubview(detailCollectionView.view)
        
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(view.topSafeAreaConstantHelper + 10)).isActive = true
        dismissButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(view.topSafeAreaConstantHelper)).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        currentTempLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        currentTempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        minTempLabel.bottomAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: -20).isActive = true
        minTempLabel.leftAnchor.constraint(equalTo: currentTempLabel.rightAnchor, constant: 20).isActive = true
        
        highestLowestSeparatorView.bottomAnchor.constraint(equalTo: minTempLabel.topAnchor, constant: -5).isActive = true
        highestLowestSeparatorView.leftAnchor.constraint(equalTo: minTempLabel.leftAnchor, constant: 0).isActive = true
        highestLowestSeparatorView.rightAnchor.constraint(equalTo: minTempLabel.rightAnchor, constant: 0).isActive = true
        highestLowestSeparatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        maxTempLabel.bottomAnchor.constraint(equalTo: highestLowestSeparatorView.topAnchor, constant: -5).isActive = true
        maxTempLabel.leftAnchor.constraint(equalTo: currentTempLabel.rightAnchor, constant: 20).isActive = true
        
        detailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        detailsLabel.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: 20).isActive = true
        
        detailsView.leftAnchor.constraint(equalTo: detailsLabel.rightAnchor, constant: 20).isActive = true
        detailsView.centerYAnchor.constraint(equalTo: detailsLabel.centerYAnchor, constant: 0).isActive = true
        detailsView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        detailsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        detailCollectionView.view.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 20).isActive = true
        detailCollectionView.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        detailCollectionView.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        detailCollectionView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 40, weight: .thin)
        label.textColor = .white
        return label
    }()
    
    let currentTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 90, weight: .ultraLight)
        label.textColor = .white
        return label
    }()
    
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 25, weight: .thin)
        label.textColor = .white
        return label
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
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
    
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.init(named: "close.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.alpha = 0.0
        return button
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "DETAILS"
        label.alpha = 0.0
        return label
    }()
    
    let detailsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 1
        view.alpha = 0.0
        return view
    }()
    

    lazy var detailCollectionView: UIViewController =  {
        let details = DetailsCollectionViewController(datasource: datasource, cityId: cityId, forecast: weatherForecastViewModel.forecast.value)
        details.view.backgroundColor = .clear
        details.view.translatesAutoresizingMaskIntoConstraints = false
        return details
    }()
}
