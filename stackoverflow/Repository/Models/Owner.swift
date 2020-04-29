//
//  Owner.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/26.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    let displayName: String?
    let reputation: Int?
    let profileImage: URL?

    private enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case reputation
        case profileImage = "profile_image"
    }
}
