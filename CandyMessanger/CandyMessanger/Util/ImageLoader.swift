//
//  ImageLoader.swift
//  CandyMessanger
//
//  Created by Hee on 2021/04/10.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    func loadImage() {
        fatalError("you must to override this method!!! 🥵")
    }
}

class URLImageLoader: ImageLoader {
    
    private var url: URL
    private var cancallable:[AnyCancellable] = []
    
    init(url: URL) {
        self.url = url
    }
    
    override func loadImage() {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ UIImage(data: $0.data)})
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                case .finished:
                    debugPrint("loadImage Completed!!! 😁")
                }
            } receiveValue: { [weak self] (image) in
                self?.image = image
            }.store(in: &cancallable)
    }
    
    
    func cancelImage() {
        cancallable.forEach { (cancelItem) in
            cancelItem.cancel()
        }
    }
    
    deinit {
        cancelImage()
    }
}

class LocalImageLoader: ImageLoader {
    
    private var imageName: String
    private var cancallable:[AnyCancellable] = []
    
    init(name: String) {
        self.imageName = name
    }
    
    override func loadImage()  {
        self.image = UIImage(named: imageName)
    }
    
}

