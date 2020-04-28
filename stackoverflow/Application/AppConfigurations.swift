//
//  AppConfigurations.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/25.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

final class AppConfigurations {
    let throttle = 0.75
    lazy var minimumSearchcharacters: Int = {
        guard let minCharacters = Bundle.main.object(forInfoDictionaryKey: "MinimumSearchcharacters") as? Int else {
            fatalError("MinimumSearchcharacters must not be empty in plist")
        }
        return minCharacters
    }()
    lazy var liveSearchEnabled: Bool = {
        guard let liveSearch = Bundle.main.object(forInfoDictionaryKey: "LiveSearchEnabled") as? Bool else {
            fatalError("Livesearch must not be empty in plist")
        }
        return liveSearch
    }()
}
