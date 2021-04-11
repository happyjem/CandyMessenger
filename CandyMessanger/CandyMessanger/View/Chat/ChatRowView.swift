//
//  ChatRowView.swift
//  CandyMessanger
//
//  Created by Hee on 2021/04/10.
//

import SwiftUI

struct ChatRowView: View {
    
    @AppStorage("current_user") var user = ""
    
    var chatDataSource: MessageModel
    
    var body: some View {
        
        HStack(spacing: 15) {
            if chatDataSource.userName != user {
                NickNameView(name: chatDataSource.userName)
            } else {
                Spacer(minLength: 0)
            }
            
            VStack(alignment: chatDataSource.userName == user ? .trailing : .leading, spacing: 5) {
                Text(chatDataSource.message)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(ChatBubble(isMessage: chatDataSource.userName == user))
                
                Text(chatDataSource.timeStamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(chatDataSource.userName != user ? .leading : .trailing, 10)
            }
            
            if chatDataSource.userName == user {
                NickNameView(name: chatDataSource.userName)
            } else {
                Spacer(minLength: 0)
            }
        }
        .padding(.horizontal)
        .id(chatDataSource.id)
        
    }
}

//struct ChatRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatRowView()
//    }
//}
