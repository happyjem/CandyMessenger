//
//  NewChatService.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/06.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol NewChatServiceProtocol {
    func create(_ recent: RecentUser) -> AnyPublisher<Void, Error>
}

final class NewChatService: NewChatServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func create(_ recent: RecentUser) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            do {
                _ = try self.db.collection("users").addDocument(from: recent)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
