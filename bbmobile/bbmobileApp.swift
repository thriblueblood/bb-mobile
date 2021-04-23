//
//  bbmobileApp.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 31/3/2564 BE.
//

import SwiftUI
import Firebase

@main
struct bbmobileApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }

}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
