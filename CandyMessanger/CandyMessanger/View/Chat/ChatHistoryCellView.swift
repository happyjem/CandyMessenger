//
//  ChatHistoryCellView.swift
//  CandyMessanger
//
//  Created by Hee on 2021/04/12.
//

import SwiftUI

struct ChatHistoryCellView: View {
    
    var recentUser: RecentUser
    
    var body: some View {
        HStack {
            AsyncImageView(name: recentUser.userImg) {
                Text("이미지 로딩중")
                    .font(.caption)
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .cornerRadius(10)
            
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 6) {
                        Text(recentUser.name).foregroundColor(.black)
                        Text(recentUser.lastmsg).foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                    Spacer()
                    VStack(alignment: .leading, spacing: 6) {
                        Text(recentUser.date).foregroundColor(.gray)
                        Text(recentUser.time).foregroundColor(.gray)
                    }
                }
                Divider()
            }
            .padding(.top, 10)
        }
        .padding(.leading, 20)
    }
}


