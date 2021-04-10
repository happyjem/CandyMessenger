//
//  NewMessageCellView.swift
//  CandyMessanger
//
//  Created by Hee on 2021/04/10.
//

import SwiftUI

struct NewMessageCellView: View {
    
    var newUser: NewUser
    
    var body: some View {
        HStack {
            AsyncImageView(name: newUser.userImg) {
                Text("이미지 로딩중")
                    .font(.caption)
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .cornerRadius(10)
            
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 6) {
                        Text(newUser.name).foregroundColor(.black)
                        Text(newUser.aboutInfo).foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                    Spacer()
                }
                Divider()
            }
            .padding(.top, 10)
        }
        .padding(.leading, 20)
    }
}

struct NewMessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageCellView(newUser: NewUser(id: "9999", name: "Test", userImg: "anonymous_01", aboutInfo: "Test Detail"))
    }
}
