//
//  ViewController.swift
//  ContactList
//
//  Created by Илья Мишин on 06.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var caller = ContactsCaller()
    
    let categories = Category.allCases
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.backgroundColor = .white
        navigationItem.title = "Контакты"
        
        caller.getContacts(controller: self)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell else { fatalError() }
        cell.accessoryType = .disclosureIndicator
        cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width * 1 / 8, bottom: 0, right: 0)
        
        let key = categories[indexPath.row]
        let amount = caller.resultsContact[key]
        
        cell.iconImage.image = UIImage(named: "\(key)")
        cell.nameLabel.text = key.categoryTitle
        cell.contactsCountLabel.text = String(amount?.count ?? 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
        let key = categories[indexPath.row]
        let contacts = caller.resultsContact[key]
        if let contacts = contacts {
            vc.contactsArray = contacts
        }
        vc.title = key.categoryTitle
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
