//
//  News.swift
//  News
//
//  Created by Nigel Gee on 05/09/2021.
//

import Foundation

enum URLComponent {
    static let baseURL = "https://newsapi.org/v2/top-headlines"
    static let country = "GB"
    static let apiKey = "Please insert your API key here"
}

struct News: Decodable {
    struct Article: Decodable, Identifiable {
        struct Source: Decodable {
            let name: String
        }

        let source: Source
        let author: String?
        let title: String
        let description: String?
        let url: URL
        let urlToImage: URL?
        let publishedAt: Date

        var id: String { title }
    }

    let totalResults: Int
    let articles: [Article]

    static let example = Article(
        source: Article.Source(name: "The Guardian"),
        author: "Graeme Wearden",
        title: "UK construction growth and car sales hit by supply chain crisis – business live - The Guardian",
        description: "Rolling coverage of the latest economic and financial news, as supply problems hurt builders and hit car sales",
        url: URL(string: "https://www.theguardian.com/business/live/2021/sep/06/uk-car-sales-supply-chain-problems-construction-pmi-builders-stock-markets-ftse-business-live")!,
        urlToImage: URL(string: "https://i.guim.co.uk/img/media/497b838007d0eb8d8170836469aa2da7dd35a956/218_0_4252_2551/master/4252.jpg?width=1200&height=630&quality=85&auto=format&fit=crop&overlay-align=bottom%2Cleft&overlay-width=100p&overlay-base64=L2ltZy9zdGF0aWMvb3ZlcmxheXMvdGctbGl2ZS5wbmc&enable=upscale&s=cee2b1a31953ca27d559780e73666996"),
        publishedAt: Date())
}
