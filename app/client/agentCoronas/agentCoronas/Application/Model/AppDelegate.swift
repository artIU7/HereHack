//
//  AppDelegate.swift
//  agentCoronas
//
//  Created by Artem Stratienko on 25.11.2020.
//

import UIKit
import NMAKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

let credentials = (
              appId: "7T8UgnMEkQDNCeJH182A",
              appCode: "wfyqs2ZxyVaiTgdkqDnIcQ",
              licenseKey: "iwH1NOVdnGRNwCpNPXh3saWaZmC4IHIAY1HK3SG+XXiS8wjKU7LG7OBjFZVHhVPqAwIp+mHHAwWX+Bx1x8/RQ3WjQCutx7m1e9RV2ZskbO31c10cqJUk1Ij+WiG7DKioPG9dOUbPHdi4O6XwZfhlMYbIqjhzgFsAjeRtsPKX0UxmDCnND9FO4SK/9ZP/dgvoTdKLG9u5RNMySPC8q5oQKB3xD7OV0T4lvpXsMvIL5Ja0/WKPHmraq6IJdHiQpwzWsloNJJ6cF76FvSOMQicDgz+29lMhfbFfdbU1IgbWKfZfuugYLVcamTHqQnm+/D2ymOo0Uq/+t2dxcF2UQ93LajZOaq5BGj92ky6aZNVqQ6vHuk1x/x2ABYTi4Fdo1oyJLjJ2fTjdmYYFB/epTjCwHyD+v7iDDEq9UznS3S6Cc1oyphpZp4pXyfyZ9G6GFx1Er+61rtUgyE1GGfmhg0jqP7Pbid5AtjOH0ImaPVzZE8eVQViDO8/o7hlprVvLJUK+Ergp6/zGhDc7KYsa4AcOntNE77u7dmY4Icgb47+Hwqw+CodjADDAYXt9xi44esj0/h224kY6ds0+yv5sOeklt3cOE6kPc11pJ+8irNzHkEtZyfnFtinW+ZqVUWDIxXiuIwt6tL7KmuVIgZxLBwPdpyFKYgUCEHj03bjFcfTbpOo="
          )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NMAApplicationContext.setAppId(credentials.appId,
                                       appCode: credentials.appCode,
                                       licenseKey: credentials.licenseKey)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

