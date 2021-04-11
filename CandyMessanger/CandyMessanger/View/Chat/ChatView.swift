//
//  ChatView.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/04.
//

import SwiftUI

struct ChatView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var scrolled = false
    @Binding var selectChatUID: String
    @StateObject var chatViewModel = ChatViewModel()
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                Text("채팅")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                Button("닫기") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            ScrollViewReader { reader in
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(chatViewModel.messages) { message in
                            ChatRowView(chatDataSource: message)
                                .onAppear() {
                                    if message.id == self.chatViewModel.messages.last?.id && !scrolled {
                                        reader.scrollTo(chatViewModel.messages.last?.id, anchor: .bottom)
                                        scrolled = true
                                    }
                                }
                        }
                        .onChange(of: chatViewModel.messages) { (value) in
                            reader.scrollTo(chatViewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                    .padding(.vertical)
                }
            }
            
            HStack(spacing: 15) {
                TextField("메세지 입력", text: $chatViewModel.txt)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .background(Color.primary.opacity(0.06))
                    .clipShape(Capsule())
                
                if chatViewModel.txt.isEmpty == false {
                    Button(action: {
                        chatViewModel.sendMessage(chatID: selectChatUID)
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background(Color("send_message_button"))
                            .clipShape(Circle())
                    })
                }
            }
            .animation(.default)
            .padding()
        }
        .onAppear {
            chatViewModel.getMessage(chatID: selectChatUID)
        }
        .ignoresSafeArea(.all, edges: .top)
       
    }
}


