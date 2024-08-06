//
//  RecentsVM.swift
//  s24-apple-maps-project
//
//  Created by Hamzah Yousuf on 4/14/24.
//

import Foundation
import Combine

class SearchHistory: ObservableObject {
    @Published var searches: [String] = []

    func addSearch(_ search: String) {
        if !searches.contains(search) {
            searches.append(search)
            if searches.count > 15 {
                searches.removeFirst()
            }
        }
    }
}
