//
//  MessageView.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/07.
//

import SwiftUI

struct MessageView: View {
    
    @State private var isShowingNewMessage = false
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 20, content: {
                
                NavigationLink(destination: NewMessage(), isActive: $isShowingNewMessage) {
                    EmptyView()
                }
                
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
