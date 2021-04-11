//
//  NickNameView.swift
//  CandyMessanger
//
//  Created by Hee on 2021/04/10.
//

import SwiftUI

struct NickNameView: View {
    
    @AppStorage("current_user") var user = ""
    var name: String
    
    var body: some View {
        Text(name)
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .frame(width: 52, height: 52)
            .background((name == user ? Color.blue : Color.green).opacity(0.5))
            .clipShape(Circle())
            .contentShape(Circle())
            .contextMenu {
                Text(name)
                    .fontWeight(.bold)
            }
    }
}

struct NickNameView_Previews: PreviewProvider {
    static var previews: some View {
        NickNameView(user: "Test User" , name: "Test Name")
    }
}
