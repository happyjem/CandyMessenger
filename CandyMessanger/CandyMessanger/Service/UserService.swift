//
//  UserService.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/04.
//

import Foundation
import UIKit
import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol UserServiceProtocol {
    func currentUser() -> AnyPublisher<User?, Never>
    func signInAnonymously() -> AnyPublisher<User, Error>
    func login(email: String, pw: String) -> AnyPublisher<Void, CandyMessengerError>
    func logout() -> AnyPublisher<Void, CandyMessengerError>
}

class UserService: UserServiceProtocol {
   
    func currentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func signInAnonymously() -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            Auth.auth().signInAnonymously { (result, error) in
                if let _error = error {
                    return promise(.failure(_error))
                } else if let user = result?.user {
                    
                    // FireStore 에 UserDB생성
                    self.createAnonymousUserForDB()
                    
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func login(email: String, pw: String) -> AnyPublisher<Void, CandyMessengerError> {
        return Future<Void, CandyMessengerError> { promise in
            Auth.auth().signIn(withEmail: email, password: pw) { (result, error) in
                if let error = error {
                    promise(.failure(.defaultCase(desc: error.localizedDescription)))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func logout() -> AnyPublisher<Void, CandyMessengerError> {
        return Future<Void, CandyMessengerError> { promise in
            do {
                try Auth.auth().signOut()
                promise(.success(()))
            } catch {
                promise(.failure(.defaultCase(desc: error.localizedDescription)))
            }
        }.eraseToAnyPublisher()
    }
    
    
    /// FireStore DB 에 Annoymouse User 를 생성한다.
    private func createAnonymousUserForDB() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        // 임의의 User Model 생성
        let userCallNum = Int.random(in: 0..<100)
        let userImgStr = "anonymous_0\(Int.random(in: 1...5))"
        let anonymousUser = NewUser(id: uid, name: "아무나 \(userCallNum)", userImg: userImgStr, aboutInfo: "아무나 사용자 \(userCallNum).")
        
        UserDefaults.standard.setValue("아무나 \(userCallNum)", forKey: "current_user")
        
        do {
            try db.collection("users").document(uid).setData(from: anonymousUser)
        } catch {
            debugPrint("Failed To \(#function) : \(error.localizedDescription)")
        }
    }
}
