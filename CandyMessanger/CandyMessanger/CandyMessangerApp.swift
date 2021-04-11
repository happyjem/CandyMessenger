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
    
    // ChatViewModel ViewModel
    @StateObject var chatViewModel = ChatViewModel()
    
    // ChatHistory ViewModel
    @StateObject var chatHistoryViewModel = ChatHistoryViewModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(loginViewModel)
                .environmentObject(newMessageViewModel)
                .environmentObject(chatViewModel)
                .environmentObject(chatHistoryViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
