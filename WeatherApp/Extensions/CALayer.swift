//
//  CALayer.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 03/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit

extension CALayer {
    
    public func configureGradientBackground(colors: [CGColor]?){
        guard let colors = colors else {
            print("Gradient colors are nil")
            return
        }
        
        let gradient = CAGradientLayer()

        let maxWidth = max(self.bounds.size.height,self.bounds.size.width)
        let squareFrame = CGRect(origin: self.bounds.origin, size: CGSize(width: maxWidth, height: maxWidth))
        gradient.frame = squareFrame

        gradient.colors = colors
       
        // If there already is a gradient sublayer we have to remove it
        if self.sublayers != nil && self.sublayers!.count > 0 && self.sublayers!.first as? CAGradientLayer != nil{
            self.sublayers!.remove(at: 0)
        }
        
        self.insertSublayer(gradient, at: 0)
    }
}
