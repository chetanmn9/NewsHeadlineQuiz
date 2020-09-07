//
//  NewsHeadlineQuizTests.swift
//  NewsHeadlineQuizTests
//
//  Created by Chetan Melkote nagaraj on 7/9/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import XCTest
@testable import NewsHeadlineQuiz

class NewsHeadlineQuizTests: XCTestCase {

    var newsFeeds: NewsFeeds!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
     func testJSONMapping() throws {
        
        guard let pathString = Bundle.main.path(forResource: "NewsFeedsSample", ofType: "json") else {
            fatalError("NewsFeedsSample.json not found")
        }

        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to String")
        }

//        print("The JSON string is: \(jsonString)")
//
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to Data")
        }
print ("The JSON Data is :\(jsonData)")
        guard let jsonDictionary = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any] else {
            fatalError("Unable to convert UnitTestData.json to JSON dictionary")
        }
//
        print("The JSON dictionary is: \(jsonDictionary)")
        
        
      //  newsFeeds.product = jsonData.product
        
     
        
        let decoder = JSONDecoder()
        //decoder.dateDecodingStrategy = .millisecondsSince1970/
       newsFeeds = try? decoder.decode(NewsFeeds.self, from: jsonData)
  
           
        XCTAssertEqual(newsFeeds.product, "Daily Buzz")
     //   print(viewModel.product)
            XCTAssertEqual(newsFeeds.resultSize, 4)
        XCTAssertEqual(newsFeeds.version, 1)

        }

}

struct NewsFeeds: Decodable {
    let product: String
    let resultSize: Int
    let version: Int
   }

//extension NewsFeeds: Unboxable {
//    init(unboxer: Unboxer) throws {
//        id = try unboxer.unbox(key: "product")
//        name = try unboxer.unbox(key: "resultSize")
//    }
//}
