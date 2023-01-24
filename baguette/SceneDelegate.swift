//
//  SceneDelegate.swift
//  baguette
//
//  Created by blue park on 2022/12/05.
//

import UIKit
import KakaoSDKAuth
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = LoginViewController() // 자신의 시작 ViewController
            window.makeKeyAndVisible()
            self.window = window
        }
}
