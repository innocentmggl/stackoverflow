//
//  QuestionListItemViewModel.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/28.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

protocol QuestionListItemViewModelOutput {
    var title: String { get }
    var body: NSAttributedString { get }
    var answersCount: String { get }
    var viewsCount: String { get }
    var ownerName: String { get }
    var ownerProfileImageUrl: URL { get }
    var ownerReputation: String { get }
    var askedTimestamp: String { get }
    var askedTimeAgo: String { get }
    var lastActivityDate: String { get }
    var tags: [String] { get }
    var id: QuestionId { get }
}

final class QuestionListItemViewModel: QuestionListItemViewModelOutput {
    
    let title: String
    let body: NSAttributedString
    let answersCount: String
    let viewsCount: String
    let ownerName: String
    let ownerProfileImageUrl: URL
    let ownerReputation: String
    let askedTimestamp: String
    let askedTimeAgo: String
    let lastActivityDate: String
    let tags: [String]
    let id: QuestionId

    init(question: Question) {
        self.id = question.id
        self.title = question.title.htmlToString
        self.body = question.body.htmlToAttributedString 
        self.answersCount = "\(AppFormatter.format(question.answersCount)) Answer\(question.answersCount > 1 ? "s":"")"
        self.viewsCount = "Viewed \(AppFormatter.format(question.viewsCount)) time\(question.answersCount > 1 ? "s":"")"
        self.ownerName = question.owner.displayName
        self.ownerProfileImageUrl = question.owner.profileImage
        self.ownerReputation = AppFormatter.format(question.owner.reputation)
        self.askedTimeAgo = "Asked \(question.created.toElapsedInterval())"
        self.askedTimestamp = "Asked \(question.created.toTimestampString()) at \(question.created.toTimeString())"
        self.lastActivityDate = "Active \(question.lastActivityDate.toElapsedInterval())"
        self.tags = question.tags
    }
}
