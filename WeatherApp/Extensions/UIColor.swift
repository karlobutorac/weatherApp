//
//  UIColor.swift
//  WeatherApp
//
//  Created by Karlo Butorac on 03/03/2020.
//  Copyright © 2020 Karlo Butorac. All rights reserved.
//

import UIKit

struct ColorScheme {
    let firstColor: UIColor
    let middleColor: UIColor
    let lastColor: UIColor
}

extension UIColor {
    static let zagrebColors = [UIColor(red: 119, green: 30, blue: 96).cgColor, UIColor(red: 165, green: 55, blue: 83).cgColor,  UIColor(red: 232, green: 93, blue: 69).cgColor]
    static let rijekaColors = [UIColor(red: 71, green: 102, blue: 159).cgColor, UIColor(red: 133, green: 128, blue: 162).cgColor,  UIColor(red: 201, green: 173, blue: 168).cgColor]
    static let splitColors  = [UIColor(red: 100, green: 163, blue: 214).cgColor, UIColor(red: 117, green: 176, blue: 218).cgColor,  UIColor(red: 130, green: 185, blue: 221).cgColor]
    static let osijekColors  = [UIColor(red: 188, green: 163, blue: 214).cgColor, UIColor(red: 173, green: 136, blue: 183).cgColor,  UIColor(red: 94, green: 94, blue: 144).cgColor]

    
    //TODO: Nes ljepse smislit
    public static func getColorScheme(for id: Int) -> [CGColor] {
        switch id {
        case 3186886:
            return zagrebColors
        case 3191648:
            return rijekaColors
        case 3193935:
            return splitColors
        case 3190261:
            return osijekColors
        default:
            return zagrebColors
        }
    }
    
    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    // Create a UIColor from a hex value (E.g 0x000000)
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
    
}
