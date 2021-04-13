//
//  BaseCustomView.swift
//  StoryPlay
//
//  Created by GENETORY on 2020/05/12.
//  Copyright © 2020 GENETORY. All rights reserved.
//

import UIKit

class BaseCustomView: UIView {

    // MARK: - Vars
    
    var containerView: UIView!

    // MARK: - Life Cycle
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    func commonInit() {
        self.containerView = Bundle.main.loadNibNamed(self.className, owner: self, options: nil)?.first as? UIView
        self.containerView.frame = self.bounds
        self.containerView.backgroundColor = kCLEAR
        self.addSubview(self.containerView)
    }

}

extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
    
}
