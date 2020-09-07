//
//  ImageLoader.swift
//  NewsHeadlineQuiz
//
//  Created by Chetan Melkote nagaraj on 7/9/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    var downloadedImage: UIImage?
    let didChange = PassthroughSubject<ImageLoader?, Never>()
    let semaphores = DispatchSemaphore(value: 0)
    
    func loadImage(url: String) {
        guard let imageURL = URL(string: url) else {
            fatalError("no Image")
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.didChange.send(nil)
                }
                return
            }
            
            self.downloadedImage = UIImage(data: data)
            self.semaphores.signal()
            DispatchQueue.main.async {
                self.didChange.send(self)
            }
        }.resume()
        self.semaphores.wait()
    }
}
