//
//  BooksService.swift
//  GoogleBooks
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

enum BooksError: Error { //associated value enum
    case badURL(String)
    case badDataTask(String)
    case badDecoder(String)
}

typealias BookHandler = (Result<[Book], BooksError>) -> Void //result closure nickname

let booksShared = BooksService.shared //property to easily access shared instance

final class BooksService {
    
    
    static let shared = BooksService()
    private init() {}
    
    
    func getBook(for bookName: String, completion: @escaping BookHandler) {
        
        guard let url = BooksAPI(bookName).searchUrl else {
            completion(.failure(.badURL("Couldn't Create Book Url"))) //return failure
            return //exit the scope
        }
        
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            
            if let error = err {
                completion(.failure(.badDataTask(error.localizedDescription)))
                return
            }
            
            if let data = dat {
                do {
                    //use ".self" to signify the TYPE of object, NOT a literal (abstract)
                    let response = try JSONDecoder().decode(BookResults.self, from: data)
                    let books = response.items
                    completion(.success(books))
                } catch {
                    completion(.failure(.badDecoder(error.localizedDescription)))
                    return
                }
            }
        }.resume()
    } 
    
}

