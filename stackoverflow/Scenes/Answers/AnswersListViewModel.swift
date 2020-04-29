//
//  AnswersListTableViewModel.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/27.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation


enum Sort: Int {
    case active
    case oldest
    case votes
}

// MARK: - INPUTS
protocol AnswersListViewModelInput {
    func viewDidLoad(with model: QuestionListItemViewModel)
    func didSelectSortSegment(at index: Int)
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
    
    func viewDidLoad(with model: QuestionListItemViewModel) {
        guard model.answersCount > 0 else { return }
        self.loading.value = true
        repository.answers(questionId: model.id) {[weak self] result in
           guard let self = self else { return }
           self.loading.value = false
           switch result {
           case .success(let questions):
               self.setResults(answers: questions)
           case .failure(let error):
               self.handleResponseError(error: error)
           }
        }
    }
    
    func didSelectSortSegment(at index: Int) {
        guard let sort = Sort(rawValue: index) else {
            return
        }
        switch sort {
        case .active:
            self.sortByActive()
        case .oldest:
            self.sortByOldest()
        case .votes:
            self.sortByVotes()
        }
    }
    
    private func handleResponseError(error: Error){
        let cancelled = error as NSError
        guard cancelled.code != -999  else {
            return
        }
        self.error.value = "Error: \(error.localizedDescription)"
    }
    
    private func setResults(answers: [Answer]) {
        self.items.value = answers.map {
            DefaultAnswersListItemViewModel(answer: $0)
        }
    }
    
    private func sortByActive(){
        self.items.value = self.items.value.sorted(by: {$0.created > $1.created})
    }
    private func sortByOldest(){
        self.items.value = self.items.value.sorted(by: {$0.created < $1.created})
    }
    private func sortByVotes(){
        self.items.value = self.items.value.sorted(by: {$0.votesCount > $1.votesCount})
    }
}
