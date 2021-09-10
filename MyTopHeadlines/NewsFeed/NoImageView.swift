//
//  NoImageView.swift
//  NoImageView
//
//  Created by Nigel Gee on 06/09/2021.
//

import SwiftUI

struct NoImageView: View {
    let source: String

    var body: some View {
        ZStack {
            Image(decorative: "Background")
                .resizable()
                .scaledToFit()
            VStack {
                Text("News")
                    .foregroundColor(.black)
                    .font(.custom("times", size: 40, relativeTo: .title))
                    .bold()
                    .padding(9)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()

                Text("\(Text("by")) \(Text(source).bold().font(.custom("times", size: 20, relativeTo: .title)))")
                    .foregroundColor(.black)
                    .padding(9)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .frame(height: 200)
        .cornerRadius(10)
    }
}

struct NoImageView_Previews: PreviewProvider {
    static var previews: some View {
        NoImageView(source: "Sky")
            .previewLayout(.sizeThatFits)
    }
}
