//
//  ExpandableNames.swift
//  grouped-contacts
//
//  Created by Diego Oruna on 4/3/19.
//  Copyright © 2019 Diego Oruna. All rights reserved.
//

import Foundation

struct ExpandableNames {
    var isExpanded:Bool
    var names:[Contact]
}

struct Contact {
    var name:String
    var hasFavorited:Bool
}
