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
    
    @State var show = false
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()

        }
    }

}
