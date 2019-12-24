//
//  BookTableCell.swift
//  GoogleBooks
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class BookTableCell: UITableViewCell {

    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var bookAuthor: UILabel!
    
    @IBOutlet weak var bookCover: UIImageView!
    
    static let identifier = "BookTableCell"

    var book: Book! {
        didSet {
            bookTitle.text = book.volumeInfo.title
            bookAuthor.text = book.volumeInfo.authors[0]
            for i in 1..<book.volumeInfo.authors.count {
                bookAuthor.text! += ", \(book.volumeInfo.authors[i])"
            }
            guard let artworkUrl = URL(string: book.volumeInfo.imageLinks["smallThumbnail"]!) else { return }
                       
                       artworkUrl.getImage { [weak self] img in
                           if let image = img {
                               self?.bookCover.image = image
                           }
            }
        }
    }
}
