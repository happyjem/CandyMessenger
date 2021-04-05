//
//  CornerShape.swift
//  CandyMessanger
//
//  Created by Coopa on 2021/04/05.
//

import SwiftUI

struct Cornerhape: Shape {
    
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 25, height: 25))
        return Path(path.cgPath)
    }
}
