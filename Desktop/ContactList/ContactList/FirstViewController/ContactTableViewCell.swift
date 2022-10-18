//
//  ContactTableViewCell.swift
//  ContactList
//
//  Created by Илья Мишин on 06.10.2022.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    static let identifier = "ContactTableViewCell"
    
    let iconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var contactsCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.tintColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(iconImage)
        contentView.addSubview(contactsCountLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 15),

            iconImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            contactsCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            contactsCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
    }
}
