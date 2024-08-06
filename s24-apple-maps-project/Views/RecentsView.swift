//
//  RecentsView.swift
//  s24-apple-maps-project
//
//  Created by Hamzah Yousuf on 4/14/24.
//

import SwiftUI

struct RecentsView: View {
    @Binding var recentSearches: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recents")
                .font(.title)
                

            List(recentSearches, id: \.self) { search in
                Text(search)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.9))
        .cornerRadius(10)
        .padding()
    }
}

struct RecentsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentsView(recentSearches: .constant([]))
    }
}
