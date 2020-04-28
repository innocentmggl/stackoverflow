//
//  AppAppearance.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/25.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
import  UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .darkGray
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
    }
}


