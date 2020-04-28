//
//  SearchListViewModel.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/25.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
import APIKit

enum SearchListViewModelNavigation {
    case none
    case navigateToAnswers(with: QuestionListItemViewModel)
}

// MARK: - INPUTS
protocol SearchListViewModelInput {
    func search(question: String?)
    func textDidChange(query: String?)
    func didSelect(item atIndexPath: Int)
}

// MARK: - OUTPUTS
protocol SearchListViewModelOutput {
    var items: Observable<[SearchListItemViewModel]> { get }
    var error: Observable<String> { get }
    var loading: Observable<Bool> { get }
    var noItemsFound: Observable<Bool> { get }
    var route: Observable<SearchListViewModelNavigation> { get }
}

protocol SearchListViewModel: SearchListViewModelInput, SearchListViewModelOutput {}

final class DefaultSearchListViewModel : SearchListViewModel {
    
    private let repository = SearchRespository()
    private let appConfigs = AppConfigurations()
    private var searchTask: DispatchWorkItem?
    private var session: SessionTask?
    private var questions: [Question] = [Question]()
    
    // MARK: - OUTPUT
    let items: Observable<[SearchListItemViewModel]> = Observable([SearchListItemViewModel]())
    let error: Observable<String> = Observable("")
    let noItemsFound: Observable<Bool> = Observable(false)
    let route: Observable<SearchListViewModelNavigation> = Observable(.none)
    let loading: Observable<Bool> = Observable(false)
    private var liveSearch: Bool { return appConfigs.liveSearchEnabled}
    private var minSearchcharacters: Int { return appConfigs.minimumSearchcharacters}
}

// MARK: - INPUT. View event methods
extension DefaultSearchListViewModel {
    
    func search(question: String?) {
        guard checkAndSetActiveSearch(query: question)  else {
            return
        }
        self.loading.value = true
        self.session?.cancel()
        self.session = repository.search(title: question!) { [weak self] result in
            guard let self = self else { return }
            self.loading.value = false
            switch result {
            case .success(let questions):
                self.setResults(questions: questions)
            case .failure(let sessionTaskError):
                self.error.value = sessionTaskError.localizedDescription
            }
        }
    }
    
    func textDidChange(query: String?) {
        if(self.liveSearch){
            self.throttle(with: query)
        }
    }
    
    private func throttle(with search: String?){
        self.searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            self?.search(question: search)
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + appConfigs.throttle, execute: task)
    }
    
    private func setResults(questions: [Question]) {
        self.questions = questions
        self.noItemsFound.value = questions.count == 0
        self.items.value = questions.map {
            DefaultSearchListItemViewModel(question: $0)
        }
    }
    
    private func checkAndSetActiveSearch(query: String?) -> Bool {
        self.noItemsFound.value = false
        self.error.value = ""
        guard let query = query, query.trimmingCharacters(in: .whitespacesAndNewlines).count >= minSearchcharacters  else {
            self.items.value = []
            return false
        }
        return true
    }
    
    func didSelect(item atIndexPath: Int) {
        self.createViewModelAndSetRoute(question: self.items.value[atIndexPath].id)
    }
    
    private func createViewModelAndSetRoute(question: QuestionId)  {
        if let question = self.questions.first(where: {$0.id == question}){
          let viewModel = QuestionListItemViewModel(question: question)
          self.route.value = .navigateToAnswers(with: viewModel)
        }
    }
}
