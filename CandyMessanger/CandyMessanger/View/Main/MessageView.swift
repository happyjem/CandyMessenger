//
//  MessageView.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/07.
//

import SwiftUI

struct MessageView: View {
    
    @State private var isShowingNewMessage = false
    @State private var isShowingChatView = false
    @State private var selectChatUID: String = ""
    
    var body: some View {
        
        
        NavigationView {
            
            VStack(spacing: 20, content: {
                
                NavigationLink(destination: NewMessage(selectChatUID: $selectChatUID), isActive: $isShowingNewMessage) {
                    EmptyView()
                }
                
                NavigationLink(destination: ChatView(selectChatUID: $selectChatUID), isActive: $isShowingChatView) {
                    EmptyView()
                }
                
                ChatHistoryView(selectChatUID: $selectChatUID)
                
            })
            .navigationBarTitle("메세지", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.isShowingNewMessage = true
            }, label: {
                Text("새 메세지")
                    .foregroundColor(Color("tabBar_select"))
            }))
            .navigationBarColor(UIColor.white, textColor: UIColor.black)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
