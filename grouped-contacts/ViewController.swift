//
//  ViewController.swift
//  grouped-contacts
//
//  Created by Diego Oruna on 4/3/19.
//  Copyright © 2019 Diego Oruna. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellId = "cellId"
        
    let contacts:[Contact] = [
        Contact(name: "Andrés", lastName: "Cervantes"),
        Contact(name: "Diego", lastName: "Oruna"),
        Contact(name: "Diana", lastName: "Cabrera"),
        Contact(name: "Denis", lastName: "Vega"),
        Contact(name: "Christian", lastName: "Galarza"),
        Contact(name: "Bruno", lastName: "Camacho"),
        Contact(name: "Barcode", lastName: "Code")
    ]

    var groupedContactsByKey = [[Contact]]()
    
    var lastIndex:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        groupContactsByKey()
        
        lastIndex = groupedContactsByKey.endIndex - 1
    }
    
    fileprivate func setupStyle(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddContact))
    }
    
    @objc fileprivate func handleAddContact(){
        print("Adding contact")
    }
    
    fileprivate func groupContactsByKey(){
        
        var groupedDictionary = Dictionary(grouping: contacts) { (contact) -> Character in
            return contact.name.first!
        }
        
        let sortedKeys = groupedDictionary.keys.sorted()
        
        sortedKeys.forEach { (key) in
            groupedContactsByKey.append(groupedDictionary[key]!)
        }
        
//        groupedContactsByKey.forEach({
//            $0.forEach({print($0.name)})
//            print("------")
//        })
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let actualContact = groupedContactsByKey[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = "\(actualContact.name) \(actualContact.lastName)"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedContactsByKey[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupedContactsByKey.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var firstCharacter:String?
        
        groupedContactsByKey[section].forEach({
            firstCharacter = String($0.name.first!)
        })
        
        return firstCharacter
    }
    
    
    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    
//        var numberOfContacts:Int = 0
//
//        groupedContactsByKey.forEach({
//            $0.forEach({ (_) in
//                numberOfContacts = numberOfContacts + 1
//            })
//        })
//
//        if section == lastIndex {
//            let footerLabel:UILabel = {
//                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
//                label.text = "\(numberOfContacts) Contacts"
//                label.textColor = .darkGray
//                label.textAlignment = .center
//                label.font = UIFont.boldSystemFont(ofSize: 14)
//                return label
//            }()
//
//            let customView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 70))
//            customView.backgroundColor = UIColor.lightGray
//
//            customView.addSubview(footerLabel)
//
//            return customView
//        }
//
//        return nil

//    }
    
    
}

