//
//  SwiftUIView.swift
//  NewsHeadlineQuiz
//
//  Created by Chetan Melkote nagaraj on 7/9/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import SwiftUI

struct wrongAnswerAnimation: View {
    var body: some View {
        LottieView(filename: "Wrong")
        .frame(width: 180, height: 180)
    }
}

struct wrongAnswerAnimation_Previews: PreviewProvider {
    static var previews: some View {
        wrongAnswerAnimation()
    }
}
