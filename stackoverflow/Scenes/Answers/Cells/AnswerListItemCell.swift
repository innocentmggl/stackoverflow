//
//  AnswerListItemCell.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/27.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit
import SDWebImage

final class AnswerListItemCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: AnswerListItemCell.self)
    
    @IBOutlet weak var votesCountLabel: UILabel!
    @IBOutlet weak var answerBodyLabel: UILabel!
    @IBOutlet weak var answeredDateLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerReputationLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var acceptedImageView: UIImageView!
    
    func configure(with viewModel: AnswersListItemViewModel) {
        self.votesCountLabel.text = viewModel.votesStr
        self.answerBodyLabel.attributedText = viewModel.body
        self.answeredDateLabel.attributedText = viewModel.answered
        self.ownerReputationLabel.text = viewModel.ownerReputation
        self.ownerNameLabel.text = viewModel.ownerName
        self.profileImageView.sd_setImage(with: viewModel.ownerProfileImage, placeholderImage: UIImage(named: "placeholder.png"))
        self.markAccepted(accepted: viewModel.accepted)
    }
    
    private func markAccepted(accepted: Bool){
        if accepted {
            self.acceptedImageView.image  = self.acceptedImageView.image?.withRenderingMode(.alwaysTemplate)
            self.acceptedImageView.tintColor = .green
        }
        else{
            self.acceptedImageView.image  = self.acceptedImageView.image?.withRenderingMode(.alwaysOriginal)
        }
    }
}
