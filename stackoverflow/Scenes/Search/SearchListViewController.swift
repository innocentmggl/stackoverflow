//
//  SearchListViewController.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/25.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.estimatedRowHeight = SearchListItemCell.height
            tableView.keyboardDismissMode = .onDrag
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet{
            searchBar.layer.borderWidth = 1
            searchBar.layer.borderColor = UIColor.orange.cgColor
        }
    }
    
    private(set) var viewModel: SearchListViewModel = DefaultSearchListViewModel()
    private var searchBarTextFieldText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDelegates()
        self.setupNavigationItems()
        self.bind(to: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func bind(to viewModel: SearchListViewModel) {
        
        viewModel.route.observe(on: self) { [weak self] route in
            self?.handle(route: route)
        }
        
        viewModel.items.observe(on: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.loading.observe(on: self) { [weak self] loading in
            loading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
        
        viewModel.noItemsFound.observe(on: self) { [weak self] found in
            self?.infoLabel.isHidden = !found
        }
        
        viewModel.error.observe(on: self) { [weak self] message in
            guard !message.isEmpty else { return }
            self?.showAlert(message: message)
        }
    }
    
    private func setupDelegates(){
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - NAVIGATION BAR SETUP
extension SearchListViewController {
    
    private func setupNavigationItems(){
        self.setupTitleView()
        self.setupLeftBarButtonItem()
    }
    
    private func setupTitleView(){
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    private func setupLeftBarButtonItem(){
        let menuButton = UIButton(type: .custom)
        menuButton.bounds = CGRect(x: 0, y: 0, width: 44, height: 44)
        menuButton.setImage(#imageLiteral(resourceName: "ic-menu"), for: .normal)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: menuButton), animated: true)
    }
}

// MARK: - SEARCH BAR SETUP
extension SearchListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.textDidChange(query: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        self.viewModel.search(question: searchBar.text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
}

// MARK: - TABLE VIEW  DELEGATE
extension SearchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelect(item: indexPath.row)
    }
}

// MARK: - TABLE VIEW DATASOURCE
extension SearchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchListItemCell.reuseIdentifier, for: indexPath) as? SearchListItemCell else {
            fatalError("Cannot dequeue reusable cell \(SearchListItemCell.self) with reuseIdentifier: \(SearchListItemCell.reuseIdentifier)")
        }
        cell.configure(with: viewModel.items.value[indexPath.row])
        return cell
    }
}

// MARK: - HANDLE NAVIGATION
extension SearchListViewController {
    func handle(route: SearchListViewModelNavigation) {
        switch route {
        case .none: break
        case .navigateToAnswers(let viewModel):
            self.searchBar.resignFirstResponder()
            let vc = AnswersListViewController.create(with: viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
