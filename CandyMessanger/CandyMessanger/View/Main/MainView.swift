//
//  MainContent.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/04.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage("log_status") var status = false
    
    var body: some View {
        if status {
            MainTabView()
        } else {
            ZStack {
                LoginView()
                SplashView()
            }
        }
    }
}

struct MainContent_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(LoginViewModel())
    }
}
