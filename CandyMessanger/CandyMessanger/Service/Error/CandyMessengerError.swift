//
//  CandyMssangerError.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/04.
//

import Foundation

enum CandyMessengerError: LocalizedError {
    
    case authentication(desc: String)
    case defaultCase(desc: String? = nil) // `default`
    
    var errorDesc: String? {
        switch self {
        case let .authentication(desc):
            return desc
        case let .defaultCase(desc):
            return desc ?? "empty error desciption"
        }
    }
}
