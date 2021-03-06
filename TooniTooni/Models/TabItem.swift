//
//  TabItem.swift
//  Petcipes
//
//  Created by GENETORY on 05/07/2019.
//  Copyright © 2019 GENETORY. All rights reserved.
//

import UIKit

enum TabType: Int {
    case home
    case schedule
    case standings
    case news
    case settings
}

struct TabItem {
    var title: String?
    var iconImage: String?
    var type: TabType?
    
    init(title: String?, iconImage: String?, type: TabType?) {
        self.title = title
        self.iconImage = iconImage
        self.type = type
    }
}
