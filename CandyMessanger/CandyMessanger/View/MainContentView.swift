//
//  MainContent.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/04.
//

import SwiftUI

struct MainContentView: View {
    
    @AppStorage("log_status") var status = false
    
    var body: some View {
        NavigationView {
            if status {
                Text("Login Sucess!!!")
            } else {
                ZStack {
                    LoginView()
                    SplashView()
                }
            }
        }
        
    }
}

struct MainContent_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
