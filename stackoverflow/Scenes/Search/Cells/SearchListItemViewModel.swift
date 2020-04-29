//
//  SearchListItemViewModel.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/26.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

protocol SearchListItemViewModelOutput {
    var title: String { get }
    var body: String { get }
    var answersCount: String { get }
    var votesCount: String { get }
    var viewsCount: String { get }
    var isAnswered: Bool { get }
    var askedDateByOwner: NSAttributedString { get }
    var id: QuestionId { get }
}

protocol SearchListItemViewModel: SearchListItemViewModelOutput {}

final class DefaultSearchListItemViewModel: SearchListItemViewModel {
    
    private(set) var id: QuestionId

    // MARK: - OUTPUT
    let title: String
    let body: String
    let answersCount: String
    let votesCount: String
    let viewsCount: String
    let askedDateByOwner: NSAttributedString
    let isAnswered: Bool

    init(question: Question) {
        self.id = question.id
        self.title = "Q: \(question.title.htmlToString)"
        self.body = question.body.htmlToString
        self.answersCount = "\(AppFormatter.format(question.answersCount)) answer\(question.answersCount > 1 ? "s":"")"
        self.votesCount = "\(AppFormatter.format(question.votesCount)) vote\(question.votesCount > 1 ? "s":"")"
        self.viewsCount = "\(AppFormatter.format(question.viewsCount)) view\(question.viewsCount > 1 ? "s":"")"
        self.isAnswered = question.isAnswered
        if let answeredBy = question.owner.displayName {
            self.askedDateByOwner = "asked \(question.created.toDateString()) by \(answeredBy)".attributedStringWithColor(strings: [answeredBy], color: .systemBlue)
        }
        else{
            self.askedDateByOwner = NSMutableAttributedString(string: "asked \(question.created.toDateString())")
        }
    }
}

func == (lhs: DefaultSearchListItemViewModel, rhs: DefaultSearchListItemViewModel) -> Bool {
    return (lhs.id == rhs.id)
}
