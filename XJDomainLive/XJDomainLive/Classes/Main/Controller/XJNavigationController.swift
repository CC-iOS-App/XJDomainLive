//
//  XJNavigationController.swift
//  XJDomainLive
//
//  Created by 李胜兵 on 2016/12/9.
//  Copyright © 2016年 付公司. All rights reserved.
//

import UIKit

class XJNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPanGes()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 1.隐藏要push的控制器的tabbar
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}


extension XJNavigationController {
    fileprivate  func setupPanGes() {
        // 1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.获取手势添加到的View中
        guard let gesView = systemGes.view else { return }
        
        // 3.获取target/action
        // 3.1.利用运行时机制查看所有的属性名称
        /*
         var count : UInt32 = 0
         let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
         for i in 0..<count {
         let ivar = ivars[Int(i)]
         let name = ivar_getName(ivar)
         print(String(cString: name!))
         }
         */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        // 3.2.取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        // 3.3.取出Action
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
    }

}