//
//  MainTabView.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/06.
//

import SwiftUI

struct MainTabView: View {
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈")
                }
            
            PersonInfoView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("사람")
                }
            
            MessageView()
                .tabItem {
                    Image(systemName: "text.bubble")
                    Text("메세지")
                }
            
            MyPageView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("마이페이지")
                }
            
            RecurtView()
                .tabItem {
                    Image(systemName: "person.crop.square.fill.and.at.rectangle")
                    Text("채용")
                }
        }
        .accentColor(Color("tabBar_select"))
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
