//
//  MyPageView.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/06.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        
        Image("under_constuction")
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: 82, height: 82)
            .frame(width: UIScreen.main.bounds.width)
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
