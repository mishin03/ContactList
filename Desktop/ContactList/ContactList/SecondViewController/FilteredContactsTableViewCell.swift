//
//  FilteredContactsTableViewCell.swift
//  ContactList
//
//  Created by Илья Мишин on 09.10.2022.
//

import UIKit
import Contacts

class FilteredContactsTableViewCell: UITableViewCell {

    static let identifier = "FilteredContactsTableViewCell"
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(emailLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            emailLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 15)
        ])
    }
    
    func configure(with contact: CNContact) {
        nameLabel.text = "\(contact.givenName) \(contact.familyName)"
        for number in contact.phoneNumbers {
            numberLabel.text = number.value.stringValue
        }
        for email in contact.emailAddresses {
            emailLabel.text = String(describing: email.value)
        }
    }
}
