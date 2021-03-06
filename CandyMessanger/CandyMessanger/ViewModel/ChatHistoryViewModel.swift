//
//  ChatViewModel.swift
//  CandyMessanger
//
//  Created by Hwang Hi on 2021/04/08.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class ChatHistoryViewModel: ObservableObject {

    @Published var recentUsers = [RecentUser]()
    @Published var noExistUser = false
    
    init() {
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        // #. Users 에 recent 테이블 정보를 계속 관찰한다.
        db.collection("users")
            .document(uid!)
            .collection("messages")
            .order(by: "timeStamp", descending: true)
            .addSnapshotListener { (snapshot, error) in
                
                guard let snap = snapshot else { return }
                
                // Error 발생한 경우
                if let _error = error {
                    debugPrint("DB Listener Error For recent : \(_error.localizedDescription)")
                    self.noExistUser = true
                    return
                }
                
                // Snapshot이 비어 있는 경우.
                if snap.isEmpty == true {
                    debugPrint("Snapshot is empty!!!")
                    self.noExistUser = true
                    return
                }
                
                for info in snap.documentChanges {
                    switch info.type {
                    case .added:
                        
                        let id = info.document.documentID
                        let uid = info.document.get("uid") as? String ?? ""
                        let name = info.document.get("userName") as? String ?? ""
                        let pic = info.document.get("userImg") as? String ?? ""
                        let lastmsg = info.document.get("message") as? String ?? ""
                        let stamp = info.document.get("timeStamp") as? Timestamp ?? Timestamp()
                        
                        let formatter = DateFormatter()
                        
                        formatter.dateFormat = "yyyy.MM.dd"
                        let date = formatter.string(from: stamp.dateValue())
                        
                        formatter.dateFormat = "hh:mm a"
                        let time = formatter.string(from: stamp.dateValue())
                        
                        let recentUser = RecentUser(id: id, name: name, userImg: pic, lastmsg: lastmsg, stemp: stamp.dateValue(), date: date, time: time, uid: uid)
                        
                        self.recentUsers.append(recentUser)
                        
                        debugPrint("Added Recent User id: \(recentUser.id ?? "none")")
                        
                    default:
                        debugPrint("Default Type")
                    }
                }
                
            }
    }
}
