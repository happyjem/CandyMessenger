//
//  ActivityIndicator.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/05.
//

import SwiftUI

struct ActivityIndicator: View {
    
    @State var animate = false
    
    let style = StrokeStyle(lineWidth: 8, lineCap: .round)
    let color = Color.gray
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(
                    AngularGradient(gradient: .init(colors: [color]), center: .center), style: style
                )
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false))
            
            Circle()
                .trim(from: 0.5, to: 0.7)
                .stroke(
                    AngularGradient(gradient: .init(colors: [color]), center: .center), style: style
                )
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false))
        }.onAppear() {
            self.animate.toggle()
        }
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}
