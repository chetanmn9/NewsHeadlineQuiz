//
//  NHQGameViewModel.swift
//  NewsHeadlineQuiz
//
//  Created by Chetan Melkote nagaraj on 7/9/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation
import Alamofire

var apiUrl = "Your API"

class NHQGameViewModel: ObservableObject {
    @Published var gameProduct : [GameQuestions] = [] //()
    @Published var gameItems = [Items]();
    @Published var itemHeadlines = [headline]();
    
    func fetchGameQuestions(completion: @escaping ([Items]) -> ()){

        AF.request(apiUrl).responseJSON { response in
            //JSON fetch error
            if let error = response.error {
                print(error)
            } else if let jsonDict = response.value as? [String: AnyObject] {
                
                print(jsonDict)
                //JSON Fetch and Array conversion
                let product = jsonDict["product"]
                let version = jsonDict["version"]
                let resultsize = jsonDict["resultSize"]
                let items = jsonDict["items"]
                if let productName = product as? String, let productVersion = version as? Int,
                   let productResultSize = resultsize as? Int, let productItems = items as? Array<Dictionary<String, AnyObject?>> {
                    
                    for i in 0..<productItems.count{
                        let itemList = productItems[i]
                        if let storyUrl = itemList["storyUrl"] as? String, let standFirst = itemList["standFirst"] as? String,
                           let correctAnswerIndex = itemList["correctAnswerIndex"] as? Int, let imageUrl = itemList["imageUrl"] as? String,
                           let section = itemList["section"] as? String, let headlines = itemList["headlines"] as? [String] {
                           
                                self.gameItems.append(Items(correctAnswerIndex: correctAnswerIndex, imageUrl: imageUrl,standFirst: standFirst, storyUrl: storyUrl, section: section, headlines: headlines))
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion(self.gameItems)        //Return Array on completion as escaping
                    }
                    self.gameProduct.append(GameQuestions(product: productName, resultSize: productResultSize, version: productVersion, items: self.gameItems))
                    
                }
                
            }
        }.resume()
    }
}
