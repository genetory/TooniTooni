//
//  BaseViewController.swift
//  StoryPlay
//
//  Created by GENETORY on 2020/05/12.
//  Copyright © 2020 GENETORY. All rights reserved.
//

import UIKit
import FirebaseAuth

class BaseViewController: UIViewController {
    
    // MARK: - Vars
    
    var showBigTitle: Bool = false
    var pageIndex: Int = 0
    var tabItem: TabItem?
    
    var firebaseHandle: AuthStateDidChangeListenerHandle?
    
    var popRecognizer: InteractivePopRecognizer?
    
    // MARK: - Life Cycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if self.firebaseHandle == nil {
            self.firebaseHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
                print("addStateDidChangeListener: \(auth), \(user)")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let firebaseHandle = self.firebaseHandle {
            Auth.auth().removeStateDidChangeListener(firebaseHandle)
            self.firebaseHandle = nil
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    deinit {
        self.removeObservers()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}

// MARK: - Observers

extension BaseViewController {
    
    func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillResignActive(sender:)),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidEnterBackground(sender:)),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillEnterForeground(sender:)),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive(sender:)),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.willResignActiveNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didEnterBackgroundNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.willEnterForegroundNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didBecomeActiveNotification,
                                                  object: nil)
    }
    
    @objc func applicationWillResignActive(sender: AnyObject) {
        
    }
    
    @objc func applicationDidEnterBackground(sender: AnyObject) {
        
    }
    
    @objc func applicationWillEnterForeground(sender: AnyObject) {
        
    }
    
    @objc func applicationDidBecomeActive(sender: AnyObject) {

    }

}

// MARK: - Alert

extension BaseViewController {
    
    func showAlertWithTitle(vc: UIViewController, title: String?, message: String) {
        let alert: UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction.init(title: "OK",
                                                         style: .default,
                                                         handler: nil)
        alert.addAction(okAction)
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    func showReadyAlert(vc: UIViewController) {
        self.showAlertWithTitle(vc: vc, title: nil, message: "준비중")
    }
    
}

// MARK: - Navigation

extension BaseViewController {
    
    func setInteractiveRecognizer() {
        guard let controller = navigationController else { return }
        
        self.popRecognizer = InteractivePopRecognizer(controller: controller)
        controller.interactivePopGestureRecognizer?.delegate = self.popRecognizer
    }

}

// MARK: - InteractivePopRecognizer

class InteractivePopRecognizer: NSObject {
    
    var navigationController: UINavigationController
    
    init(controller: UINavigationController) {
        self.navigationController = controller
    }
    
}

// MARK: - UIGestureRecognizer Delegate

extension InteractivePopRecognizer: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController.viewControllers.count > 1
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

}
