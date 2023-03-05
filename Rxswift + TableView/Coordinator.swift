//
//  Coordinator.swift
//  Rxswift + TableView
//
//  Created by 이청준 on 2023/03/05.
//

import UIKit

class Coordinator {
    let window:UIWindow
    
    init(window: UIWindow){
        self.window = window
    }
    
    // 첫진입점 화면설정해주기
    func start(){
        let rootviewController = RootViewController()
        let navigationRootViewController = UINavigationController(rootViewController: rootviewController)
        window.rootViewController = navigationRootViewController  // 첫진입점 화면설정해주기
        window.makeKeyAndVisible()
    }
}
