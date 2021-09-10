//
//  NewsFeedModel.swift
//  NewsFeedModel
//
//  Created by Nigel Gee on 05/09/2021.
//

import Foundation

extension NewsFeedView {
    class ViewModel: ObservableObject {
        @Published var newsFeed = [News.Article]()
        @Published var country = Country.country(code: URLComponent.country)
        @Published var showingCountryView = false
        @Published var errorAlert = false
        @Published var errorMessage = ""
        @Published var totalResults = 0
        @Published var currentPage = 1

        var endURL: String {
            URLComponent.baseURL + "?country=" + country.code + "&page=" + String(currentPage) + "&apiKey=" + URLComponent.apiKey
        }

        var numPages: Int {
            (Double(totalResults / 20) == Double(totalResults) / 20.0) ? (totalResults / 20) : (totalResults / 20) + 1
        }

        func incrementPage() {
            currentPage = (currentPage == numPages) ? 1 : currentPage + 1
        }

        @MainActor
        func getNews() async {
            do  {
                let userURL = URL(string: endURL)!
                async let news: News = try await URLSession.shared.decode(News.self, from: userURL, dateDecodingStrategy: .iso8601)
                newsFeed = try await news.articles
                totalResults = try await news.totalResults
            } catch {
                print(endURL)
                errorMessage = error.localizedDescription
                errorAlert = true
            }
        }
    }
}

