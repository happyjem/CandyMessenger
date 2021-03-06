//
//  NewMessageViewModel.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/06.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class NewMessageeViewModel: ObservableObject {
    
    @Published var myAuthUsers = [NewUser]()
    @Published var searchText: String = ""
    
    // #. filter data
    private var allUsers = [NewUser]()
    
    // #. Cancellable (like disposebag)
    private var cancallable:[AnyCancellable] = []
    
    enum Action {
        case getAllUser
    }
    
    // #. new chat Service
    private let newChatService: NewChatServiceProtocol
    
    init(newChatService: NewChatServiceProtocol = NewChatService()) {
        self.newChatService = newChatService
        
        // Set Propety Listener
        self.listen()
    }
    
    func send(action: Action) {
        switch action {
        case .getAllUser:
            newChatService.getAllUsers().sink { completion in
                switch completion {
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                case .finished:
                    debugPrint("getAllUser Completed!!! ð")
                }
            } receiveValue: { (users) in
                self.myAuthUsers = users
                // ėė ė ėĨ
                self.allUsers = users
            }.store(in: &cancallable)
        }
    }
    
    private func listen() {
        
        // ėŽėĐė ęēė
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                case .finished:
                    debugPrint("SearchText Completed!!! ð")
                }
            } receiveValue: { (source) in
                debugPrint("Input Data: \(source)")
                if self.searchText.isEmpty == false {
                    self.myAuthUsers = self.allUsers.filter({ $0.name.contains(source)})
                    debugPrint("Search Result: \(self.myAuthUsers)")
                } else {
                    // ęēėėīę° ėė ęē―ė° ëŠĻë  ė ė ëĨž ëģīėŽėĪëĪ.
                    self.myAuthUsers = self.allUsers
                }
            }.store(in: &cancallable)
    }
    
}

