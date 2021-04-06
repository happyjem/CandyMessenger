//
//  LoginContextView.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/05.
//

import SwiftUI

struct LoginContextView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        
        VStack {
            Text("Login")
                .font(.largeTitle)
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 32)
            
            VStack {
                TextField("email", text:$loginViewModel.email)
                    .padding(.vertical, 11)
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                    .padding(.bottom, 15)
                
                TextField("password", text:$loginViewModel.password)
                    .padding(.vertical, 11)
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    HStack {
                        Spacer()
                        Text("Login")
                        Spacer()
                    }
                })
                .foregroundColor(.white)
                .padding(.vertical, 15)
                .padding(.horizontal)
                .background(Color("login_button"))
                .cornerRadius(8.0)
                .padding(.top, 15)
                
                Button(action: {
                    loginViewModel.send(action: .createGuest)
                }, label: {
                    HStack {
                        Spacer()
                        Text("Guest(Anonymous Log In)")
                        Spacer()
                    }
                })
                .foregroundColor(.white)
                .padding(.vertical, 15)
                .padding(.horizontal)
                .background(Color("guest_button"))
                .cornerRadius(8.0)
                .padding(.top, 10
                )
            }
            .padding(.top, 10)
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
}

struct LoginContextView_Previews: PreviewProvider {
   
    static let loginViewModel = LoginViewModel()
    
    static var previews: some View {
        LoginContextView().environmentObject(loginViewModel)
    }
}
