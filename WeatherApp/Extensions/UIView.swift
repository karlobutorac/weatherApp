//
//  UIView.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 06/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit

extension UIView {
    func copyView<T: UIView>() -> T {
        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)) as! T
    }
}


extension UIView {
    func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.25) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration) {
                self.alpha = alpha
            }
        }
    }
    
    func fadeIn(_ duration: TimeInterval = 0.25) {
        fadeTo(1.0, duration: duration)
    }
    
    func fadeOut(_ duration: TimeInterval = 0.25) {
        fadeTo(0.0, duration: duration)
    }
    
    var hasTopNotch: Bool {
        if #available(iOS 13.0,  *) {
            return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 20
        }else{
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
    }
    
    
    var topSafeAreaConstantHelper: Int {
        if #available(iOS 13.0,  *) {
            return Int(UIApplication.shared.windows.filter{$0.isKeyWindow}.first!.safeAreaInsets.top)
            
        }else{
            return Int((UIApplication.shared.delegate?.window!?.safeAreaInsets.top)!)
        }
    }
}


