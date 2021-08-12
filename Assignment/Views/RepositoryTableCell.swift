//
//  RepositoryTableCell.swift
//  Assignment
//
//  Created by Shreyak Godala on 12/08/21.
//

import UIKit
import Kingfisher

class RepositoryTableCell: UITableViewCell {
    
    
    var repository: Repository? {
        didSet{
            guard let repository = repository else {return}
            ownerNameLabel.text = repository.owner?.login ?? ""
            titleLabel.text = repository.name ?? ""
            descriptionLabel.text = repository.description ?? ""
            starCountLabel.text = "\(repository.stargazersCount ?? 0)"
            
            if let url = URL(string: repository.owner?.avatarUrl ?? "") {
                repoIcon.kf.setImage(with: url)
            }
            
            
        }
    }
    
    lazy var repoIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iv.layer.cornerRadius = 2
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var ownerNameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .systemGray
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return l
    }()
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return l
    }()
    
    lazy var descriptionLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return l
    }()
    
    lazy var starImage: UIImageView = {
        let smallConfiguration = UIImage.SymbolConfiguration(scale: .small)
        let smallSymbolImage = UIImage(systemName: "star", withConfiguration: smallConfiguration)
        let iv = UIImageView(image: smallSymbolImage)
        iv.tintColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var starCountLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return l
    }()
    
    lazy var languageLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let topStack = UIStackView(arrangedSubviews: [repoIcon, ownerNameLabel])
        topStack.axis = .horizontal
        topStack.alignment = .center
        topStack.spacing = 8
        
        let bottomStack = UIStackView(arrangedSubviews: [starImage, starCountLabel, languageLabel])
        bottomStack.axis = .horizontal
        bottomStack.alignment = .center
        bottomStack.spacing = 2
        
        bottomStack.setCustomSpacing(16, after: starCountLabel)
        
        let fullStack = UIStackView(arrangedSubviews: [topStack, titleLabel, descriptionLabel, bottomStack])
        fullStack.axis = .vertical
        fullStack.spacing = 4
        fullStack.alignment = .leading
        fullStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(fullStack)
        fullStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        fullStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        fullStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        fullStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
