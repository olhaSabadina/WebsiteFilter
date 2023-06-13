//
//  SceneDelegate.swift
//  WebsiteFilter
//
//  Created by Olya Sabadina on 2023-06-05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let startVC = WebBrowserVC()
        let navigationVC = UINavigationController(rootViewController: startVC)
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
}
