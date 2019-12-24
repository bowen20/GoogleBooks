//
//  ViewModel.swift
//  GoogleBooks
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func update()
}

class ViewModel {
    
    weak var delegate: ViewModelDelegate?
    
    var books = [Book]() {
        didSet {
            delegate?.update()
        }
    }
    
    var currentBook: Book!
    
}

extension ViewModel {
    
    func get(_ bookName: String) {
        booksShared.getBook(for: bookName) { [weak self] booksResult in
            switch booksResult {
            case .success(let books):
                self?.books = books
                print("Book Count: \(books.count)")
            case .failure(let error):
                print("Books Failure: \(error.localizedDescription)")
            }
        }
    }

}

