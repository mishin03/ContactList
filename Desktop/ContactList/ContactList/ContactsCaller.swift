//
//  ContactsCaller.swift
//  ContactList
//
//  Created by Илья Мишин on 09.10.2022.
//

import UIKit
import Contacts

enum Category: CaseIterable {
    
    case allContacts
    case dublicateNames
    case dublicateNumbers
    case noName
    case noNumber
    case noEmail
    
    var categoryTitle: String {
        switch self {
        case .allContacts:
            return "Контакты"
        case .dublicateNames:
            return "Повторяющиеся имена"
        case .dublicateNumbers:
            return "Дубликаты номеров"
        case .noName:
            return "Нет имени"
        case .noNumber:
            return "Нет номера"
        case .noEmail:
            return "Нет электронной почты"
        }
    }
}

class ContactsCaller {
    
    var resultsContact: [Category : [CNContact]] = [:]
    
    func getContacts(controller: UIViewController) {
        let store = CNContactStore()
        var contacts = [CNContact]()
        store.requestAccess(for: .contacts) { success, error in
            if success {
                do {
                    let predicate = CNContact.predicateForContactsInContainer(withIdentifier: store.defaultContainerIdentifier())
                    contacts = try store.unifiedContacts(matching: predicate, keysToFetch: [
                        CNContactPhoneNumbersKey as CNKeyDescriptor,
                        CNContactFamilyNameKey as CNKeyDescriptor,
                        CNContactGivenNameKey as CNKeyDescriptor,
                        CNContactEmailAddressesKey as CNKeyDescriptor
                    ])
                    
                    var phoneNumbers: Set<String> = []
                    var names: Set<String> = []
                    var repeatedNamesSet: Set<String> = []
                    var repeatedNumbersSet: Set<String> = []
                    var noNames: [CNContact] = []
                    var noNumbers: [CNContact] = []
                    var noEmails: [CNContact] = []
                    
                    for contact in contacts {
                        for phoneNumber in contact.phoneNumbers {
                            let number = phoneNumber.value.stringValue.filter("01234567890.".contains)
                            if phoneNumbers.contains(number) {
                                repeatedNumbersSet.insert(number)
                            } else {
                                phoneNumbers.insert(number)
                            }
                        }
                        let name = contact.givenName
                        if names.contains(name) {
                            repeatedNamesSet.insert(name)
                        } else {
                            names.insert(name)
                        }
                        if contact.phoneNumbers.isEmpty {
                            noNumbers.append(contact)
                        }
                        if contact.givenName.isEmpty {
                            noNames.append(contact)
                        }
                        if contact.emailAddresses.isEmpty {
                            noEmails.append(contact)
                        }
                    }

                    var dublicatedNumbers: [CNContact] = []
                    var repeatedNames: [CNContact] = []
                    
                    for contact in contacts {
                        for phoneNumber in contact.phoneNumbers {
                            let number = phoneNumber.value.stringValue.filter("01234567890.".contains)
                            if repeatedNumbersSet.contains(number) {
                                dublicatedNumbers.append(contact)
                            }
                        }
                        if repeatedNamesSet.contains(contact.givenName) {
                            repeatedNames.append(contact)
                        }
                    }
                    
                    let dublicateNames = repeatedNames.sorted { $0.givenName < $1.givenName }
                    
                    self.resultsContact[.allContacts] = contacts
                    self.resultsContact[.dublicateNumbers] = dublicatedNumbers
                    self.resultsContact[.dublicateNames] = dublicateNames
                    self.resultsContact[.noName] = noNames
                    self.resultsContact[.noNumber] = noNumbers
                    self.resultsContact[.noEmail] = noEmails
                    
                } catch {
                    print(error)
                }
            } else {
                DispatchQueue.main.async {
                    let alertController = UIAlertController (title: "Permission was not granted for Contacts", message: "Go to Settings?", preferredStyle: .alert)
                    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                print("Settings opened: \(success)")
                            })
                        }
                    }
                    alertController.addAction(settingsAction)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                    alertController.addAction(cancelAction)
                    controller.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
