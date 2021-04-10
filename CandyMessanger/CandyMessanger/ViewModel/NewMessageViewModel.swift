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
                    debugPrint("getAllUser Completed!!! 😁")
                }
            } receiveValue: { (users) in
                self.myAuthUsers = users
                // 임시 저장
                self.allUsers = users
            }.store(in: &cancallable)
        }
    }
    
    private func listen() {
        
        // 사용자 검색
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                case .finished:
                    debugPrint("SearchText Completed!!! 😁")
                }
            } receiveValue: { (source) in
                debugPrint("Input Data: \(source)")
                if self.searchText.isEmpty == false {
                    self.myAuthUsers = self.allUsers.filter({ $0.name.contains(source)})
                    debugPrint("Search Result: \(self.myAuthUsers)")
                } else {
                    // 검색어가 없을 경우 모든 유저를 보여준다.
                    self.myAuthUsers = self.allUsers
                }
            }.store(in: &cancallable)
    }
    
}

