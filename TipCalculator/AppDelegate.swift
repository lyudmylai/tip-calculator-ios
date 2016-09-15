//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Lyudmyla Ivanova on 9/6/16.
//  Copyright © 2016 Lyudmyla Ivanova. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let theme = ThemeManager.currentTheme()
    ThemeManager.applyTheme(theme)
    let defaultsDictionary = ["kMinimumTip" : 18,
                              "kDefaultTip" : 20,
                              "kMaximumTip" : 25,
                              "kTheme"      : 0]
    UserDefaults.standard.register(defaults: defaultsDictionary)
    UserDefaults.standard.synchronize()
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }
}

