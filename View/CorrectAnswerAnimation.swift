//
//  CorrectAnswerAnimation.swift
//  NewsHeadlineQuiz
//
//  Created by Chetan Melkote nagaraj on 7/9/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import SwiftUI

struct CorrectAnswerAnimation: View {
    var body: some View {
        LottieView(filename: "Correct")
            .frame(width: 200, height: 200)
    }
}

struct CorrectAnswerAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CorrectAnswerAnimation()
    }
}
