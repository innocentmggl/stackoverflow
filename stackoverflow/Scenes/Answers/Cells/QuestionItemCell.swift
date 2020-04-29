//
//  QuestionItemCell.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/27.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit
import SDWebImage
import TagListView

protocol QuestionCellDelegater {
    func sortSegment(didSelectSegmentAt index: Int)
}

final class QuestionItemCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: QuestionItemCell.self)
    var delegate: QuestionCellDelegater?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var askedTimeAgoLabel: UILabel!
    @IBOutlet weak var lastActiveLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var createdTimestampLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var answersCountLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tagListView: TagListView!
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        delegate?.sortSegment(didSelectSegmentAt: sender.selectedSegmentIndex)
    }
    
    func configure(with viewModel: QuestionListItemViewModel) {
        self.titleLabel.text = viewModel.title
        self.askedTimeAgoLabel.attributedText = viewModel.askedTimeAgo
        self.bodyLabel.attributedText = viewModel.body
        self.lastActiveLabel.attributedText = viewModel.lastActivityDate
        self.createdTimestampLabel.attributedText = viewModel.askedTimestamp
        self.viewsLabel.attributedText = viewModel.viewsCount
        self.displayNameLabel.text = viewModel.ownerName
        self.reputationLabel.text = viewModel.ownerReputation
        self.answersCountLabel.text = viewModel.answered
        self.profileImageView.sd_setImage(with: viewModel.ownerProfileImageUrl, placeholderImage: UIImage(named: "placeholder.png"))
        self.tagListView.removeAllTags()
        self.tagListView.addTags(viewModel.tags)
        self.segmentControl.isEnabled = viewModel.answersCount > 1
    }
}

