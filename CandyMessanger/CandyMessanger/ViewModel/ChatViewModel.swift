//
//  ChatViewModel.swift
//  CandyMessanger
//
//  Created by Hee on 2021/04/10.
//

import Foundation
import Combine
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ChatViewModel: ObservableObject {
    
    @Published var txt = ""
    @Published var messages = [MessageModel]()
    @AppStorage("current_user") var user = ""
    
    // #. Chat Service
    private let chatService: ChatServiceProtocol
    
    // #. Cancellable (like disposebag)
    private var cancallable:[AnyCancellable] = []
    
    let db = Firestore.firestore()
    
    init(chatService: ChatServiceProtocol = ChatService()) {
        self.chatService = chatService
        
        chatService.messagePublisher
            .assign(to: \.messages, on: self)
            .store(in: &cancallable)
    }
    
    func sendMessage(chatID: String) {
        let message = MessageModel(id: chatID, message: txt, uid: chatID, userName: user, userImg: "", timeStamp: Date())
        chatService.sendMsg(message: message)
    }
    
    func getMessage(chatID: String) {
        chatService.getMessages(chatID: chatID)
    }
}
