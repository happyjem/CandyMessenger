//
//  NewMessage.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/04.
//

import SwiftUI

struct NewMessage: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        Text("New Message")
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

struct NewMessage_Previews: PreviewProvider {
    static var previews: some View {
        NewMessage()
    }
}
