//
//  ContactCell.swift
//  grouped-contacts
//
//  Created by Diego Oruna on 4/4/19.
//  Copyright © 2019 Diego Oruna. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    var link:ViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
        starButton.tintColor = .red
        starButton.addTarget(self, action: #selector(handleMarkAsFav), for: .touchUpInside)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        accessoryView = starButton
    }
    
    @objc fileprivate func handleMarkAsFav(){
        print("Marking as favorite")
        link?.someMethod(cell: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
