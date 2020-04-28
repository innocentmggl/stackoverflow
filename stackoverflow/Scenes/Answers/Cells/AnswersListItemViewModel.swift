//
//  AnswersListItemViewModel.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/27.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

protocol AnswersListItemViewModelOutput  {
    var accepted: Bool { get }
    var body: NSAttributedString { get }
    var votesCount: String { get }
    var ownerName: String { get }
    var ownerReputation: String { get }
    var ownerProfileImage: URL { get }
    var answered: String { get }
}

protocol AnswersListItemViewModel: AnswersListItemViewModelOutput {}

final class DefaultAnswersListItemViewModel: AnswersListItemViewModel {

    // MARK: - OUTPUT
    let accepted: Bool
    let votesCount: String
    let body: NSAttributedString
    let ownerName: String
    let ownerReputation: String
    let ownerProfileImage: URL
    let answered: String

    init(answer: Answer) {
        self.accepted = answer.accepted
        self.votesCount = "\(AppFormatter.format(answer.votesCount))\nVote\(answer.votesCount > 1 ? "s":"")"
        self.body = answer.body.htmlToAttributedString
        self.ownerName = answer.owner.displayName
        self.ownerReputation = AppFormatter.format(answer.owner.reputation)
        self.ownerProfileImage = answer.owner.profileImage
        self.answered = "answered \(answer.created.toTimestampString()) at \(answer.created.toTimeString())"
    }
}
