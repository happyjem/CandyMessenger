//
//  AsyncImageView.swift
//  CandyMessanger
//
//  Created by Hee on 2021/04/10.
//

import SwiftUI

struct AsyncImageView<Placeholder: View>: View {
    
    @StateObject private var imgLoader: ImageLoader
    
    private let placeholder: Placeholder
    
    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _imgLoader = StateObject(wrappedValue: URLImageLoader(url: url))
    }
    
    init(name: String, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _imgLoader = StateObject(wrappedValue: LocalImageLoader(name: name))
    }
    
    var body: some View {
        content
            .onAppear(perform: imgLoader.loadImage)
    }
    
    private var content: some View {
        Group {
            if let loadedImg = imgLoader.image {
                Image(uiImage: loadedImg).resizable()
            } else {
                placeholder
            }
        }
    }
}


