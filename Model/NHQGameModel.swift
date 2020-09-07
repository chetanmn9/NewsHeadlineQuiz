//
//  NHQGameModel.swift
//  NewsHeadlineQuiz
//
//  Created by Chetan Melkote nagaraj on 7/9/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation

//Data Model
struct GameQuestions: Identifiable, Decodable {
    
    var id = UUID()
    let product: String
    let resultSize: Int
    let version: Int
    let items: [Items]
    
    init(product: String, resultSize: Int, version: Int, items: [Items]) {
        self.product = product
        self.resultSize = resultSize
        self.version = version
        self.items = items
    }
}

struct Items: Identifiable, Decodable {
    var id = UUID()
    var correctAnswerIndex: Int
    var imageUrl: String
    var standFirst: String
    var storyUrl: String
    var section: String
    var headlines: [String]
    
    init(correctAnswerIndex: Int, imageUrl: String, standFirst: String, storyUrl: String, section: String, headlines: [String] ) {
        self.correctAnswerIndex = correctAnswerIndex
        self.imageUrl = imageUrl
        self.standFirst = standFirst
        self.storyUrl = storyUrl
        self.section = section
        self.headlines = headlines
    }
}

struct headline: Identifiable, Decodable{
    var id = UUID()
    var headlines: [headline]
    
}
