//
//  SignUpViewModel.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/05.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var bio = ""
    @Published var age = ""
}
