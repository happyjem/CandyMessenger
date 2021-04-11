//
//  Message.swift
//  CandyMessanger
//
//  Created by Hee on 2021/04/10.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

struct MessageModel: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String?
    
    var message: String
    var uid: String
    var userName: String
    var userImg: String
    var timeStamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case message
        case uid
        case userName
        case userImg
        case timeStamp
    }
}
