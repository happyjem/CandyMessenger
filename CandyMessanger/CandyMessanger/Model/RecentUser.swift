//
//  RecentUser.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/06.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

struct RecentUser: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String?
    
    var name: String
    var userImg: String
    var lastmsg: String
    var stemp: Date
    var date: String
    var time: String
    var uid: String
}
