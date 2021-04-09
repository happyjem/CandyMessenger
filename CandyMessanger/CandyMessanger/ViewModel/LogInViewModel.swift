//
//  LogInViewModel.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/05.
//

import Foundation
import Combine
import FirebaseAuth

typealias UserId = String

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    // #. User Service
    private let userService: UserServiceProtocol
    
    // #. Cancellable (like disposebag)
    private var cancallable:[AnyCancellable] = []
    
    enum Action {
        case createGuest
        //case login(email: String, password: String)
    }
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func send(action: Action) {
        switch action {
        case .createGuest:
            getCurrentUserId().sink { (completion) in
                switch completion {
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                case .finished:
                    debugPrint("getCurrentUserId Completed!!! 😁")
                }
            } receiveValue: { (userId) in
                debugPrint("current user id => \(userId)")
                // Main 화면으로 변경
                UserDefaults.standard.set(true, forKey: "log_status")
            }.store(in: &cancallable)

        }
    }
    
    // #. Get Current UserId
    private func getCurrentUserId() -> AnyPublisher<UserId, Error> {
        return userService.currentUser().flatMap { (user) -> AnyPublisher<UserId, Error> in
            if let userId = user?.uid {
                return Just(userId)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return self.userService.signInAnonymously()
                    .map({$0.uid})
                    .eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
    
    // #. Login
    private func login() {
        
    }
    
}
