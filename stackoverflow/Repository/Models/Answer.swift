//
//  Answer.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/26.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

struct Answer: Decodable {
    let accepted: Bool
    let votesCount: Int
    let body: String
    let owner: Owner
    let created: Date

    private enum CodingKeys: String, CodingKey {
        case accepted = "is_accepted"
        case votesCount = "score"
        case body
        case owner
        case created = "creation_date"
    }
}

struct AnswersResponse: Decodable {
    let items: [Answer]
}
