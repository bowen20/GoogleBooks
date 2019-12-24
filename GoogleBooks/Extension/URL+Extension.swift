//
//  URL+Extension.swift
//  GoogleBooks
//
//  Created by Consultant on 12/22/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

extension URL {
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: self) { (dat, _, _) in
            if let data = dat {
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    completion(image)
                }
            }
        }.resume()
    }
}
