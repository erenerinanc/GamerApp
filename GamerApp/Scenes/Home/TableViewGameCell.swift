//
//  TableViewGameCell.swift
//  GamerApp
//
//  Created by Eren Erinanç on 14.09.2021.
//

import UIKit
import SnapKit
import Nuke

class TableViewGameCell: UITableViewCell {
    static let reuseID = "TableViewGameCell"
    
    let gameImageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        contentView.addSubview(gameImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.backgroundColor = Colors.background
        
        gameImageView.contentMode = .scaleAspectFill
        gameImageView.layer.cornerRadius = CGFloat(10)
        gameImageView.clipsToBounds = true
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.textColor = .white
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        descriptionLabel.textColor = Colors.secondaryLabel
        
        gameImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(8)
            make.width.equalTo(70)
            make.height.equalTo(gameImageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(gameImageView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview().inset(8)
            make.top.equalToSuperview().offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(gameImageView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview().inset(8)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
    }
    
    func set(for viewModel: Home.Fetch.ViewModel.Game) {
        DispatchQueue.main.async {
            Nuke.loadImage(with: viewModel.imageURL, into: self.gameImageView)
            self.nameLabel.text = viewModel.name
            self.descriptionLabel.text = "\(viewModel.releasedDate)  \(String(viewModel.rating))"
        }
    }

}
