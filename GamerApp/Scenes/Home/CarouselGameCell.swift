//
//  CarouselCell.swift
//  GamerApp
//
//  Created by Eren Erinanç on 11.09.2021.
//

import UIKit
import SnapKit
import Nuke

class CarouselCell: UICollectionViewCell {
    static let reuseID = "CarouselGameCell"
    
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
        
        imageView.layer.cornerRadius = CGFloat(20)
        imageView.clipsToBounds = true
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().offset(8)
            make.height.equalToSuperview().inset(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
    }
    
    func set(for viewModel: Home.Fetch.ViewModel.Game) {
        DispatchQueue.main.async {
            Nuke.loadImage(with: viewModel.imageURL, into: self.imageView)
            self.nameLabel.text = viewModel.name
            self.descriptionLabel.text = "\(viewModel.releasedDate)  \(String(viewModel.rating))"
        }
    }
}
