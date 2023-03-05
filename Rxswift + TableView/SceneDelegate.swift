//
//  SceneDelegate.swift
//  Rxswift + TableView
//
//  Created by 이청준 on 2023/03/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // 첫화면 설정
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        let coordinator = Coordinator(window: self.window!)
        coordinator.start()
    }


}

