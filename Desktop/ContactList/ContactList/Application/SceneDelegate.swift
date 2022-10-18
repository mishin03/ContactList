//
//  SceneDelegate.swift
//  ContactList
//
//  Created by Илья Мишин on 06.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        var window = UIWindow(windowScene: windowScene)

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        
        self.window = UIWindow(windowScene: windowScene)

        let rootNC = UINavigationController(rootViewController: ViewController())

        self.window?.rootViewController = rootNC
        self.window?.makeKeyAndVisible()
    }
}
