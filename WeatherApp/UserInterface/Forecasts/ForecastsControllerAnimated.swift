//
//  ForecastControllerAnimated.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 11/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import Foundation
import UIKit

extension ForecastsController: AnimatedTransition {
    
    func animateTransition(for indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
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
     
     private func animateTransition(of cell: ForecastsCell, with forecast: Forecast, from fromFrame: CGRect? = nil, to toFrame: CGRect, inside view: UIView, duration: Double, usingSpringWithDamping: CGFloat = 1.0, completion: @escaping (Bool) -> Void) {
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
    
    
}