//
//  Book.swift
//  GoogleBooks
//
//  Created by Consultant on 12/23/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct BookResults: Decodable {
    let items: [Book]
}

class Book: Decodable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    let title: String
    let authors: [String]
    let imageLinks: [String: String]
}
