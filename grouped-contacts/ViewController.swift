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
    
    func someMethod(cell:UITableViewCell) {

        guard let indexPathTapped = tableView.indexPath(for: cell) else {return}
        
        let contact = twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row]
        
        let hasFavorited = contact.hasFavorited
        
        twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
        
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
        
        print(contact)

    }
    
    var twoDimensionalArray = [
        ExpandableNames(isExpanded: true, names: ["Amy","Bill","Zack","Diego","Carlos","Jack","Steve","Mary","Cleveland"].map({Contact(name: $0, hasFavorited: false)})),
        
        ExpandableNames(isExpanded: true, names: ["Amy","Bill","Zack","Diego","Carlos","Jack","Steve","Mary","Cleveland"].map({Contact(name: $0, hasFavorited: false)})),
        
        ExpandableNames(isExpanded: true, names: [Contact(name: "Diego", hasFavorited: false)])
    ]
    
//    var showIndexPaths = false

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Contacts"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Indexpath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
    }
    
//    @objc fileprivate func handleShowIndexPath(){
    
//        var indexPathsToReload = [IndexPath]()
//
//        for section in twoDimensionalArray.indices {
//            for row in twoDimensionalArray[section].names.indices{
//                let indexPath = IndexPath(row: row, section: section)
//                indexPathsToReload.append(indexPath)
//            }
//        }
//
//        showIndexPaths = !showIndexPaths
//        let animations = showIndexPaths ? UITableView.RowAnimation.right : .left
//        tableView.reloadRows(at: indexPathsToReload, with: animations)
//
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleOpenClose), for: .touchUpInside)
        
        button.tag = section
        
        return button
    }
    
    @objc fileprivate func handleOpenClose(button:UIButton){

        let section = button.tag
        
        var indexPaths = [IndexPath]()
        
        for row in twoDimensionalArray[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open":"Close", for: .normal)
        
        if !isExpanded{
            tableView.insertRows(at: indexPaths, with: .fade)
        }else {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded{
            return 0
        }
        return twoDimensionalArray[section].names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        cell.link = self

        let contact = twoDimensionalArray[indexPath.section].names[indexPath.row]
        
        cell.accessoryView?.tintColor = contact.hasFavorited ? UIColor.red : .lightGray
        
//        if showIndexPaths{
//            cell.textLabel?.text = "\(contact.name) Section:\(indexPath.section) Row:\(indexPath.row)"
//        } else {
        cell.textLabel?.text = contact.name
//        }
        
        return cell
    }

}

