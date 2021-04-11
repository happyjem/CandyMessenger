//
//  ChatService.swift
//  CandyMessanger
//
//  Created by Hee on 2021/04/10.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

/// Service Interface
protocol ChatServiceProtocol {
    
    var messages: [MessageModel] { get set }

    var messagePublished: Published<[MessageModel]> { get }
    var messagePublisher: Published<[MessageModel]>.Publisher { get }
    
    func sendMsg(message: MessageModel)
    func getMessages(chatID: String)
}

final class ChatService: ChatServiceProtocol {
    
    @Published var messages = [MessageModel]()
    
    var messagePublished: Published<[MessageModel]> { _messages }
    var messagePublisher: Published<[MessageModel]>.Publisher { $messages }
    
    func sendMsg(message: MessageModel) {
        
        let db = Firestore.firestore()
        
        do {
            let _ = try db.collection("users").document(message.uid).collection("messages").addDocument(from: message)
        } catch {
            debugPrint("Failed To \(#function) : \(error.localizedDescription)")
        }
    }
    
    func getMessages(chatID: String) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(chatID).collection("messages").order(by: "timeStamp", descending: false).addSnapshotListener({ (snapshot, error) in
            
            if let _error = error {
                debugPrint("Failed To \(#function) : \(_error.localizedDescription)")
                return
            }
            
            guard let data = snapshot else { return }
            data.documentChanges.forEach { (source) in
                if source.type == .added {
                    do {
                        if let message = try source.document.data(as: MessageModel.self) {
                            DispatchQueue.main.async {
                                self.messages.append(message)
                            }
                        } else {
                            throw CandyMessengerError.defaultCase(desc: "메세지 없음!!!")
                        }
                    } catch {
                        debugPrint("Failed To \(#function) : \(error.localizedDescription)")
                    }
                }
            }
        })
    }
}
