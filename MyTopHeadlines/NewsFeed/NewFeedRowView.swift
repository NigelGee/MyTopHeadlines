//
//  NewFeedRowView.swift
//  NewFeedRowView
//
//  Created by Nigel Gee on 06/09/2021.
//

import SwiftUI

struct NewFeedRowView: View {
    let article: News.Article

    var body: some View {
        VStack {
            if let imageURL = article.urlToImage {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(10)
            } else {
                NoImageView(source: article.source.name)
            }
            
            VStack(alignment: .leading) {
                Text(article.title)
                    .bold()
                    .font(.title2)
                    .layoutPriority(1)

                Text(article.description ?? "")

                HStack {
                    VStack(alignment: .leading) {
                        Text(article.source.name)
                        Text(article.author ?? "")
                        HStack(spacing: 3) {
                            Text(article.publishedAt, style: .date)
                            Text("@")
                            Text(article.publishedAt, style: .time)
                        }
                    }
                    .font(.caption)
                    Spacer()
                    Link(destination: article.url) {
                        Text("Read More")
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct NewFeedRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewFeedRowView(article: News.example)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
