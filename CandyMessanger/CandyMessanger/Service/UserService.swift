//
//  UserService.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/04.
//

import Foundation
import Combine
import FirebaseAuth

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
}
