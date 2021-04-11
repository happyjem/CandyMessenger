//
//  ChatHistoryView.swift
//  CandyMessanger
//
//  Created by Hee on 2021/04/10.
//

import SwiftUI

struct ChatHistoryView: View {
    
    @Binding var selectChatUID: String
    @State private var isShowingChatView = false
    @EnvironmentObject var chatHistoryViewModel: ChatHistoryViewModel
    
    var body: some View {
        
        List {
            
            ForEach(chatHistoryViewModel.recentUsers) { recent in
                Button(action: {
                    self.selectChatUID = recent.uid
                    isShowingChatView = true
                }) {
                    ChatHistoryCellView(recentUser: recent)
                }
                .fullScreenCover(isPresented: $isShowingChatView) {
                    ChatView(selectChatUID: $selectChatUID)
                }
            }
            .listRowInsets(EdgeInsets())
            .background(Color.white)
        }
        .listRowBackground(Color.white)
    }
}

