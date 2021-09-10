//
//  CountryListView.swift
//  CountryListView
//
//  Created by Nigel Gee on 08/09/2021.
//

import SwiftUI

struct CountryListView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var country: Country

    var body: some View {
        List(Country.countries) { country in
            HStack {
                Text("\(country.flag) \(country.name)")
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                self.country = country
                dismiss()
            }
        }
    }
}
