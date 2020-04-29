//
//  QuestionDetailsTableViewController.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/27.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
import UIKit

final class AnswersListViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    private var questionViewModel: QuestionListItemViewModel!
    private var viewModel: AnswersListViewModel = DefaultAnswersListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    final class func create(with viewModel: QuestionListItemViewModel) -> AnswersListViewController {
        let view = AnswersListViewController.instantiate()
        view.questionViewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
        self.title = "More Info"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.bind(to: viewModel)
        viewModel.viewDidLoad(with: questionViewModel)
    }

    func bind(to viewModel: AnswersListViewModel) {
        
        viewModel.items.observe(on: self) { [weak self] _ in
            UIView.setAnimationsEnabled(false)
            self?.tableView.beginUpdates()
            self?.tableView.reloadSections([1], with: .none)
            self?.tableView.endUpdates()
        }
        
        viewModel.loading.observe(on: self) { [weak self] loading in
            loading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
        
        viewModel.error.observe(on: self) { [weak self] message in
            guard !message.isEmpty else { return }
            self?.showAlert(message: message)
        }
    }
}

// MARK: - TABLE VIEW DATASOURCE
extension AnswersListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionItemCell.reuseIdentifier, for: indexPath) as? QuestionItemCell else {
                fatalError("Cannot dequeue reusable cell \(QuestionItemCell.self) with reuseIdentifier: \(QuestionItemCell.reuseIdentifier)")
            }
            cell.delegate = self
            cell.configure(with: questionViewModel)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerListItemCell.reuseIdentifier, for: indexPath) as? AnswerListItemCell else {
            fatalError("Cannot dequeue reusable cell \(AnswerListItemCell.self) with reuseIdentifier: \(AnswerListItemCell.reuseIdentifier)")
        }
        cell.configure(with: viewModel.items.value[indexPath.row])
        return cell
    }
}

// MARK: - TABLE VIEW  DELEGATE
extension AnswersListViewController: UITableViewDelegate {}

// MARK: - SORT DELEGATE
extension AnswersListViewController: QuestionCellDelegater {
    func sortSegment(didSelectSegmentAt index: Int) {
        self.viewModel.didSelectSortSegment(at: index)
    }
}
