//
//  Question.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/26.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

typealias QuestionId = Int

struct Question: Decodable {
    let id: QuestionId
    let viewsCount: Int
    let answersCount: Int
    let votesCount: Int
    let title: String
    let body: String
    let owner: Owner
    let tags: [String]
    let created: Date
    let lastActivityDate: Date
    let isAnswered: Bool

    private enum CodingKeys: String, CodingKey {
        case id = "question_id"
        case viewsCount = "view_count"
        case title
        case body
        case owner
        case tags
        case created = "creation_date"
        case isAnswered = "is_answered"
        case answersCount = "answer_count"
        case votesCount = "score"
        case lastActivityDate = "last_activity_date"
    }
}

struct QuestionsResponse: Decodable {
    let items: [Question]
}
