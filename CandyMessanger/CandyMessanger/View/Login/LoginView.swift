//
//  Login.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/04.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        
        VStack {
            Image("login_intro")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: UIScreen.main.bounds.height / 3.2)
                .padding(.top)
            
            ZStack {
                LoginContextView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.ignoresSafeArea(.all, edges: .bottom))
            .clipShape(Cornerhape(corners: [.topLeft, .topRight]))
        }
        .background(Color("login_background").ignoresSafeArea(.all, edges: .all))
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


