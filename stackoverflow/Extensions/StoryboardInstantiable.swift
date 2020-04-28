//
//  StoryboardInstantiable.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/25.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable: UIViewController {}

extension StoryboardInstantiable {
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: className, bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with class name \(className)")
        }
        return vc
    }

    static func instantiateWithNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: className, bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? UINavigationController else {
            fatalError("Cannot instantiate initial view controller \(Self.self) with navigation controller from storyboard with class name \(className)")
        }
        return vc
    }
}

extension NSObject {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    var className: String {
        return type(of: self).className
    }
}
