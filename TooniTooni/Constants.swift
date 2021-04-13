//
//  Constants.swift
//  StoryPlay
//
//  Created by GENETORY on 2020/05/12.
//  Copyright © 2020 GENETORY. All rights reserved.
//

import UIKit

// MARK: - Device

let kDEVICE_WIDTH: CGFloat =                        UIScreen.main.bounds.size.width
let kDEVICE_HEIGHT: CGFloat =                       UIScreen.main.bounds.size.height

let kDEVICE_TOP_AREA: CGFloat =                     UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
let kDEVICE_BOTTOM_AREA: CGFloat =                  UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.bottom ?? 0.0

// MARK: - Navigation

let kNAVIGATION_BIG_HEIGHT: CGFloat =               100.0
let kNAVIGATION_SMALL_HEIGHT: CGFloat =             44.0

// MARK: - Radians

extension CGFloat {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
    var radiansToDegrees: CGFloat { return CGFloat(self) * 180 / .pi }
}

