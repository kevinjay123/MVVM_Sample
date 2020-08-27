//
//  CocktailDetailTableViewCell.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import UIKit
import Kingfisher

class CocktailDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var categoryLabel: UILabel!

    @IBOutlet weak var cocktailImageView: UIImageView!

    @IBOutlet weak var instructionLabel: UILabel!

    private var viewModel: CocktailDetailTableViewCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.name
            categoryLabel.text = viewModel?.category
            cocktailImageView.kf.indicatorType = .activity
            cocktailImageView.kf.setImage(with: viewModel?.imgUrl)
            instructionLabel.text = viewModel?.instruction
        }
    }

    func bindViewModel(by cocktail: Cocktail) {
        viewModel = CocktailDetailTableViewCellViewModel(cocktail)
    }
}
