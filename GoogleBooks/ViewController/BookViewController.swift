//
//  BookViewController.swift
//  GoogleBooks
//
//  Created by Consultant on 12/23/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UIKit

class BookViewController: UIViewController {

    
    @IBOutlet weak var bookCover: UIImageView!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    
    @IBOutlet weak var bookAuthor: UILabel!
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        bookTitle.text = viewModel.currentBook.volumeInfo.title
        bookAuthor.text = viewModel.currentBook.volumeInfo.authors[0]
        for i in 1..<viewModel.currentBook.volumeInfo.authors.count {
            bookAuthor.text! += ", \(viewModel.currentBook.volumeInfo.authors[i])"
        }
        guard let artworkUrl = URL(string: viewModel.currentBook.volumeInfo.imageLinks["smallThumbnail"]!) else { return }
                              
        artworkUrl.getImage { [weak self] img in
        if let image = img {
            self?.bookCover.image = image
            }
        }
        super.viewDidLoad()
    }


}

