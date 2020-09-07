//
//  URLImage.swift
//  NewsHeadlineQuiz
//
//  Created by Chetan Melkote nagaraj on 7/9/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct URLImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    var placeholder: Image
    init(url: String, placeholder: Image = Image("SkyScrappers")) {
        self.placeholder = placeholder
        self.imageLoader.loadImage(url: url)
    }
        
    var body: some View {
        if let uiImage = self.imageLoader.downloadedImage {
            return Image(uiImage: uiImage).resizable()
        } else {
            return placeholder
        }
    }
}
