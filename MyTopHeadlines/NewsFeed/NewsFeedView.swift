//
//  ContentView.swift
//  MyTopHeadlines
//
//  Created by Nigel Gee on 05/09/2021.
//

import SwiftUI

struct NewsFeedView: View {
    @StateObject var viewModel = ViewModel()
    @State private var search = ""

    var searchResults: [News.Article] {
        if search.isEmpty {
            return viewModel.newsFeed
        } else {
            return viewModel.newsFeed.filter {
                $0.source.name.lowercased().contains(search.lowercased()) ||
                $0.title.lowercased().contains(search.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.newsFeed.isEmpty {
                    ProgressView("Loading News")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)))
                        .shadow(radius: 10)
                } else {
                    List(searchResults) { article in
                        NewFeedRowView(article: article)
                    }
                    .searchable(text: $search)
                }
            }
            .task {
                await viewModel.getNews()
            }
            .refreshable {
                viewModel.incrementPage()
                await viewModel.getNews()
            }
            .navigationTitle("\(viewModel.country.name) News")
            .toolbar {
                Button {
                    viewModel.showingCountryView = true
                } label: {
                    Text(viewModel.country.flag)
                        .font(.largeTitle)
                }
            }
            .sheet(isPresented: $viewModel.showingCountryView) {
                Task {
                    viewModel.newsFeed = []
                    await viewModel.getNews()
                }
            } content: {
                CountryListView(country: $viewModel.country)
            }
            .alert("Failed to fetch news!", isPresented: $viewModel.errorAlert) {
                Button("Reset", role: .cancel) {
                    Task {
                        viewModel.country = Country.country(code: "GB")
                        await viewModel.getNews()
                    }
                }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
