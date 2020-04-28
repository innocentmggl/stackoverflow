//
//  AnswersListTableViewModel.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/27.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

// MARK: - INPUTS
protocol AnswersListViewModelInput {
    func viewDidLoad(with questionId: QuestionId)
}

// MARK: - OUTPUTS
protocol AnswersListViewModelOutputs {
    var items: Observable<[AnswersListItemViewModel]> { get }
    var error: Observable<String> { get }
    var loading: Observable<Bool> { get }
}

protocol AnswersListViewModel: AnswersListViewModelInput, AnswersListViewModelOutputs {}

final class DefaultAnswersListViewModel: AnswersListViewModel {
    
    private let repository = AnswerRepository()
    // MARK: - OUTPUT
    let items: Observable<[AnswersListItemViewModel]> = Observable([AnswersListItemViewModel]())
    let error: Observable<String> = Observable("")
    let loading: Observable<Bool> = Observable(false)
}
// MARK: - INPUTS
extension DefaultAnswersListViewModel {
    
    func viewDidLoad(with questionId: QuestionId) {
        self.loading.value = true
        repository.answers(questionId: questionId) {[weak self] result in
           guard let self = self else { return }
           self.loading.value = false
           switch result {
           case .success(let questions):
               self.setResults(answers: questions)
           case .failure(let sessionTaskError):
               self.error.value = sessionTaskError.localizedDescription
           }
        }
    }
    
    private func setResults(answers: [Answer]) {
        self.items.value = answers.map {
            DefaultAnswersListItemViewModel(answer: $0)
        }
    }
}
