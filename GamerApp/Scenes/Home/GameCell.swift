//
//  GameCell.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import UIKit
import SnapKit

class GameCell: UICollectionViewCell {
    static let reuseId = "Game"
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func set(for viewModel: Home.Case.ViewModel.Game) {
        self.imageView.image = UIImage(named: viewModel.imageURL)
        self.nameLabel.text = viewModel.name
        self.descriptionLabel.text = "\(viewModel.releasedDate)  \(String(viewModel.rating))"
    }
}
