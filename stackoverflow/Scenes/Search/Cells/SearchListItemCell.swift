//
//  SearchListItemCell.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/26.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit

final class SearchListItemCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: SearchListItemCell.self)
    static let height = CGFloat(120)
    
    @IBOutlet private weak var answeredImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var askedDateByOwnerLabel: UILabel!
    @IBOutlet private weak var answersCountLabel: UILabel!
    @IBOutlet private weak var votesCountLabel: UILabel!
    @IBOutlet private weak var viewsCountLabel: UILabel!
    @IBOutlet private weak var isAnsweredImageView: UIImageView!
    
    func configure(with viewModel: SearchListItemViewModel) {
        self.titleLabel.text = viewModel.title
        self.bodyLabel.text = viewModel.body
        self.answersCountLabel.text = viewModel.answersCount
        self.votesCountLabel.text = viewModel.votesCount
        self.viewsCountLabel.text = viewModel.viewsCount
        self.askedDateByOwnerLabel.attributedText = viewModel.askedDateByOwner
        self.markAnswered(isAnswered: viewModel.isAnswered)
    }
    
    private func markAnswered(isAnswered: Bool){
        if isAnswered {
            self.isAnsweredImageView.image  = self.isAnsweredImageView.image?.withRenderingMode(.alwaysTemplate)
            self.isAnsweredImageView.tintColor = .green
        }
        else{
            self.isAnsweredImageView.image  = self.isAnsweredImageView.image?.withRenderingMode(.alwaysOriginal)
        }
    }
}

