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
    
    @Published var recentUsers = [RecentUser]()
    
    init() {
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("users")
            .document(uid!)
            .collection("recent")
            .order(by: "date", descending: true)
    }
    
}

