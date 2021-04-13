//
//  GeneralHelper.swift
//  StoryPlay
//
//  Created by GENETORY on 2020/05/12.
//  Copyright © 2020 GENETORY. All rights reserved.
//

import UIKit
import AudioToolbox

let kUSER_DEFAULT_SHOW_RESULT =                             "USER_DEFAULT_SHOW_RESULT"

class GeneralHelper {

    // MARK: - Vars
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    var settingsList: [SettingsItem] = []
    var tabList: [TabItem] = []
    
    var showResult = true
    var needRefreshShowResult = false

    static let sharedInstance = GeneralHelper()
    
    // MARK: - Life Cycle
    
    func setup() {
        self.initUserDefaults()
        self.loadShowResult()
        
        self.initTabList()
        self.initSettingsList()
    }

}

// MARK: - User Defaults

extension GeneralHelper {
    
    func initUserDefaults() {
        UserDefaults.standard.register(defaults: [kUSER_DEFAULT_SHOW_RESULT : true])
    }
    
}

// MARK: - Show Result

extension GeneralHelper {
    
    func saveShowResult(_ show: Bool) {
        self.needRefreshShowResult = true
        
        UserDefaults.standard.setValue(show, forKey: kUSER_DEFAULT_SHOW_RESULT)
        UserDefaults.standard.synchronize()
        
        self.loadShowResult()
    }
    
    func loadShowResult() {
        self.showResult = UserDefaults.standard.bool(forKey: kUSER_DEFAULT_SHOW_RESULT)
    }
    
}

// MARK: - Tab

extension GeneralHelper {

    func initTabList() {
        let homeItem = TabItem.init(title: kTITLE_HOME, iconImage: "icon_menu_off_home", type: .home)
        let scheduleItem = TabItem.init(title: kTITLE_SCHEDULE, iconImage: "icon_menu_off_schedule", type: .schedule)
        let standingItem = TabItem.init(title: kTITLE_STANDINGS, iconImage: "icon_menu_off_ranking", type: .standings)
        let newsItem = TabItem.init(title: kTITLE_NEWS, iconImage: "icon_menu_off_news", type: .news)
        let settingsItem = TabItem.init(title: kTITLE_SETTINGS, iconImage: "icon_menu_off_settings", type: .settings)

        self.tabList = [homeItem, scheduleItem, standingItem, newsItem, settingsItem]
    }

}

// MARK: - Settings

extension GeneralHelper {
    
    func initSettingsList() {
        let pushItem = SettingsItem.init(title: "푸시 알림 설정", switch_: true, type: .push)
        let resultItem = SettingsItem.init(title: "경기 결과 표시", arrow: true, type: .result)
        let patchItem = SettingsItem.init(title: "패치 노트", arrow: true, type: .patch)
        let privacyItem = SettingsItem.init(title: "개인정보 처리방침", arrow: true, type: .privacy)
        let termsItem = SettingsItem.init(title: "서비스 이용약관", arrow: true, type: .terms)
        let versionItem = SettingsItem.init(title: "버전", subTitle: String().appVersion + " (" + String().appBuild + ")", type: .versions)
        let devItem = SettingsItem.init(title: "서버 변경", arrow: true, type: .dev)

        self.settingsList = [pushItem, resultItem, patchItem, privacyItem, termsItem, versionItem, devItem]
    }
    
}

// MARK: - Make ViewController

extension GeneralHelper {

    func makeVC(_ storyBoard: String, _ viewController: String) -> BaseViewController {
        let sb = UIStoryboard.init(name: storyBoard, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: viewController) as! BaseViewController
        
        return vc
    }
    
    func makePageVC(_ storyBoard: String, _ viewController: String) -> UIPageViewController {
        let sb = UIStoryboard.init(name: storyBoard, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: viewController) as! UIPageViewController
        
        return vc
    }
    
    func makeTabBarViewController(_ storyBoard: String, _ viewController: String) -> UITabBarController {
        let sb: UIStoryboard = UIStoryboard.init(name: storyBoard, bundle: nil)
        let vc: BaseTabBarViewController = sb.instantiateViewController(withIdentifier: viewController) as! BaseTabBarViewController
        
        return vc
    }

}

// MARK: - Push Notification

extension GeneralHelper {
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }

}

// MARK: - Vibrate

extension GeneralHelper {
    
    func doVibrate() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

}
