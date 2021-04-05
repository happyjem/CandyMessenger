//
//  SplashView.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/04.
//

import SwiftUI

struct SplashView: View {
    
    @State var isAnimate = false
    @State var endSplash = false
    
    var body: some View {
        
        ZStack {
            Color("background")
            
            Image("candy_big")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: isAnimate ? .fill : .fit)
                .frame(width: isAnimate ? nil : 82, height: isAnimate ? nil : 82)
                .scaleEffect(isAnimate ? 1.5 : 1)
                .frame(width: UIScreen.main.bounds.width)
        }
        .ignoresSafeArea(.all, edges: .all)
        .onAppear(perform: {
            animateSplash()
        })
        .opacity(endSplash ? 0 : 1)
        
    }
    
    private func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeOut(duration: 0.55)) {
                isAnimate.toggle()
            }
            
            withAnimation(.linear(duration: 0.45)) {
                endSplash.toggle()
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
       SplashView()
    }
}

