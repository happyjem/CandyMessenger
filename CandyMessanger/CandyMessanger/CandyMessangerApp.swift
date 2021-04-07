//
//  CandyMessangerApp.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/04.
//

import SwiftUI
import Firebase

@main
struct CandyMessangerApp: App {
    
    // CoreDate용 persistence controller
    let persistenceController = PersistenceController.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // Login ViewModel
    @StateObject var loginViewModel = LoginViewModel()
    
    // NewMessage ViewModel
    @StateObject var newMessageViewModel = NewMessageeViewModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(loginViewModel)
                .environmentObject(newMessageViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
