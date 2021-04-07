//
//  NewUser.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/07.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

struct NewUser: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String?
    
    var name: String
    var userImg: String
    var aboutInfo: String
}
