//
//  NewMessage.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/04.
//

import SwiftUI

struct NewMessage: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var newMessageViewModel: NewMessageeViewModel
    
    var body: some View {
        
        VStack {
            
            VStack {
                HStack {
                    TextField("받는 사람", text: $newMessageViewModel.searchText)
                        .padding(.horizontal, 35)
                        .frame(width: UIScreen.main.bounds.width - 110, height: 45, alignment: .leading)
                        .background(Color.clear)
                        .clipped()
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 10)
                            }
                        )
                    Spacer()
                }
                Divider().padding(.horizontal, 20)
            }
            .padding(.top, 30)
            .padding(.leading, 12)
            .padding(.bottom, 20)
                
            List {
                Section(header:
                            ListHeader(name: "연결된 사람", color: Color.white)
                ) {
                    ForEach(newMessageViewModel.myAuthUsers) { newUser in
                        //Text("\(newUser.name)")
                        NewMessageCellView(newUser: newUser)
                    }
                    .listRowInsets(EdgeInsets())
                    .background(Color.white)
                }
                .listRowBackground(Color.white)
            }
            .onAppear() {
                newMessageViewModel.send(action: .getAllUser)
            }

        }
        .navigationBarTitle("새 메세지", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "xmark")
                .foregroundColor(Color("tabBar_select"))
        })
            
    }
}


struct ListHeader: View {
    let name: String
    let color: Color

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(name)
                    .font(.caption)
            }
            .padding(.leading, 20)
            Spacer()
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(FillAll(color: color))
    }
}

struct FillAll: View {
    let color: Color
    
    var body: some View {
        GeometryReader { proxy in
            self.color.frame(width: UIScreen.main.bounds.width, height: proxy.size.height).fixedSize()
        }
    }
}

struct NewMessage_Previews: PreviewProvider {
    static var previews: some View {
        NewMessage()
    }
}
