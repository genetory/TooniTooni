//
//  BaseTabBarViewController.swift
//  NewOPGG
//
//  Created by Jiyoun Moon on 2018. 6. 26..
//  Copyright © 2018년 Genetory. All rights reserved.
//

import UIKit
import AVKit

class BaseTabBarViewController: UITabBarController {

    // MARK: - Vars
    
    var showTab = false
    var pageIndex: Int! = 0
    var selectedTabIdx: Int = 0
        
    // MARK: - Life Cycle
    
    func initVars() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func initBackgroundView() {

    }
    
    func initNavigationView() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func initTabBar() {
        let whiteView: UIView = UIView()
        whiteView.backgroundColor = kWHITE
        whiteView.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: kDEVICE_WIDTH, height: kDEVICE_HEIGHT))
        self.tabBar.addSubview(whiteView)

        UITabBar.appearance().tintColor = kGRAY_700
        UITabBar.appearance().backgroundImage = UIImage.imageFromColor(kWHITE)
        UITabBar.appearance().shadowImage = UIImage.imageFromColor(kGRAY_200)
        UITabBar.appearance().selectionIndicatorImage = UIImage.imageFromColor(kGRAY_100)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kGRAY_500, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9.0)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kGRAY_700, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9.0)], for: .disabled)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kGRAY_700, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9.0)], for: .selected)

        if let tabBarItems = self.tabBar.items {
            for (index, tabItem) in GeneralHelper.sharedInstance.tabList.enumerated() {
                tabBarItem.tag = index
                
                let tabBarItem = tabBarItems[index]
                tabBarItem.title = tabItem.title
                tabBarItem.image = UIImage.init(named: tabItem.iconImage!)?.withRenderingMode(.alwaysOriginal)
                tabBarItem.selectedImage = UIImage.init(named: tabItem.iconImage!.replacingOccurrences(of: "off", with: "on"))
                tabBarItem.tag = index
            }
        }
    }
    
    func initViewControllers() {
        var controllers: [UINavigationController] = []
        
        for tabItem in GeneralHelper.sharedInstance.tabList {
            var storyBoard: String?
            var controller: String?
            
            if tabItem.type == .home {
                storyBoard = "Home"
                controller = "HomeViewController"
            }
            else if tabItem.type == .schedule{
                storyBoard = "Schedule"
                controller = "ScheduleViewController"
            }
            else if tabItem.type == .standings {
                storyBoard = "Standings"
                controller = "StandingViewController"
            }
            else if tabItem.type == .news {
                storyBoard = "News"
                controller = "NewsViewController"
            }
            else if tabItem.type == .settings {
                storyBoard = "Settings"
                controller = "SettingsViewController"
            }
            
            if let storyBoard = storyBoard,
                let controller = controller {
                let vc: BaseViewController = GeneralHelper.sharedInstance.makeVC(storyBoard, controller)
                vc.tabItem = tabItem
                
                let nc: UINavigationController = UINavigationController.init(rootViewController: vc)
                controllers.append(nc)
            }
        }
        
        self.viewControllers = controllers
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initVars()
        self.initBackgroundView()
        self.initViewControllers()
        self.initTabBar()

        if let viewControllers = self.viewControllers {
            self.selectedViewController = viewControllers[self.selectedTabIdx]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
        
}

// MARK: -

extension BaseTabBarViewController {
    
    func openNews() {
        self.selectedIndex = 3
    }
    
}


//// MARK: - Tabbar
//
//extension BaseTabBarViewController {
//
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        self.selectedTabIdx = item.tag
//
//        let tabItem = GeneralHelper.sharedInstance.tabList[item.tag]
//        switch tabItem.type {
//        case .home:
//            TrackingHelper.sharedInstance.sendLog(location: kTRACKING_LOCATION_RANKING,
//                                                  action: kTRACKING_ACTION_VISIT,
//                                                  parameter: nil,
//                                                  value: nil)
//        case .discover:
//            TrackingHelper.sharedInstance.sendLog(location: kTRACKING_LOCATION_DISCOVER,
//                                                  action: kTRACKING_ACTION_VISIT,
//                                                  parameter: nil,
//                                                  value: nil)
//        case .community:
//            TrackingHelper.sharedInstance.sendLog(location: kTRACKING_LOCATION_MYPAGE,
//                                                  action: kTRACKING_ACTION_VISIT,
//                                                  parameter: nil,
//                                                  value: nil)
//
//        case .profile:
//            TrackingHelper.sharedInstance.sendLog(location: kTRACKING_LOCATION_MYPAGE,
//                                                  action: kTRACKING_ACTION_VISIT,
//                                                  parameter: nil,
//                                                  value: nil)
//        default:
//            return
//        }
//    }
//
//}
//
