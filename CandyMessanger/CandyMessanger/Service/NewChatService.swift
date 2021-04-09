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

/// Service Interface
protocol NewChatServiceProtocol {
    func create(_ user: NewUser) -> AnyPublisher<Void, Error>
    func getAllUsers() -> AnyPublisher<[NewUser], Error>
}

/// 신규 메세징을 위한 리스트를 제공하는 서비스
final class NewChatService: NewChatServiceProtocol {
    
    private let db = Firestore.firestore()
    
    /// 새로운 유저를 생성한다.
    /// - Parameter user: 추가되는 User Instance
    /// - Returns: AnyPublisher<Void, Error>
    func create(_ user: NewUser) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            do {
                _ = try self.db.collection("users").addDocument(from: user)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    /// 로그인 된 모든 유저를 불러온다.
    /// - Returns:AnyPublisher<[User], Error>
    func getAllUsers() -> AnyPublisher<[NewUser], Error> {
        return Future<[NewUser], Error> { promise in
            self.db.collection("users").getDocuments { (snapshot, error) in
                
                guard let _snapshot = snapshot else {
                    return
                }
                
                if let _error = error {
                    debugPrint("Failed Load to User Colletion : \(_error.localizedDescription)")
                    promise(.failure(_error))
                }
                else if _snapshot.documents.isEmpty == true {
                    debugPrint("User Document is empty!!!")
                    promise(.success([NewUser]()))
                }
                else {
                    
                    var users = [NewUser]()
                    
                    for userInfo in _snapshot.documents {
                        
                        let id = userInfo.documentID
                        let name = userInfo.get("name") as? String ?? ""
                        let userImg = userInfo.get("userImg") as? String ?? ""
                        let aboutInfo = userInfo.get("aboutInfo") as? String ?? ""
                        
                        users.append(NewUser(id: id, name: name, userImg: userImg, aboutInfo: aboutInfo))
                        
                    }
                    promise(.success(users))
                }
            }
        }.eraseToAnyPublisher()
    }
}
