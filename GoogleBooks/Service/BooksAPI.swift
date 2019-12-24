//
//  BooksAPI.swift
//  GoogleBooks
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct BooksAPI {
    
    //https://www.googleapis.com/books/v1/volumes?q=
    
    var searchTerm: String!
    
    let base = "https://www.googleapis.com/books/v1/volumes?q="
    
    init(_ search: String? = nil) {
        self.searchTerm = search
    }
    
    var searchUrl: URL? {
        guard let search = searchTerm else { return nil }
        return URL(string: base + search)
    }
    
}
