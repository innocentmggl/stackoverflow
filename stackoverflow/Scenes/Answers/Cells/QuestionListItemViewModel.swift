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
    var answersCount: Int { get }
    var answered: String { get }
    var viewsCount: NSAttributedString { get }
    var ownerName: String? { get }
    var ownerProfileImageUrl: URL? { get }
    var ownerReputation: String { get }
    var askedTimestamp: NSAttributedString { get }
    var askedTimeAgo: NSAttributedString { get }
    var lastActivityDate: NSAttributedString { get }
    var tags: [String] { get }
    var id: QuestionId { get }
    
}

final class QuestionListItemViewModel: QuestionListItemViewModelOutput {
    
    let title: String
    let body: NSAttributedString
    let answersCount: Int
    let answered: String
    let viewsCount: NSAttributedString
    let ownerName: String?
    let ownerProfileImageUrl: URL?
    let ownerReputation: String
    let askedTimestamp: NSAttributedString
    let askedTimeAgo: NSAttributedString
    let lastActivityDate: NSAttributedString
    let tags: [String]
    let id: QuestionId

    init(question: Question) {
        self.id = question.id
        self.title = question.title.htmlToString
        self.body = question.body.htmlToAttributedString
        self.answersCount = question.answersCount
        self.answered = "\(AppFormatter.format(question.answersCount)) Answer\(question.answersCount > 1 ? "s":"")"
        self.ownerName = question.owner.displayName
        self.ownerProfileImageUrl = question.owner.profileImage
        self.ownerReputation = AppFormatter.format(question.owner.reputation)
        let elapsedInterval = question.created.toElapsedInterval()
        self.askedTimeAgo = "Asked \(elapsedInterval)".attributedStringWithColor(strings: [elapsedInterval], color: .darkGray)
        let activeAgo = question.lastActivityDate.toElapsedInterval()
        self.lastActivityDate = "Active \(activeAgo)".attributedStringWithColor(strings: [activeAgo], color: .darkGray)
        let viewed = "\(AppFormatter.format(question.viewsCount)) time\(question.viewsCount > 1 ? "s":"")"
        self.viewsCount = "Viewed \(viewed)".attributedStringWithColor(strings: [viewed], color: .darkGray)
        let asked = "\(question.created.toTimestampString()) at \(question.created.toTimeString())"
        self.askedTimestamp = "Asked \(asked)".attributedStringWithColor(strings: [asked], color: .darkGray)
        self.tags = question.tags
    }
}
