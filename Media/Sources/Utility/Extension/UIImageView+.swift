//
//  UIImageView+.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import UIKit

extension UIImageView {
    func setImage(with url: URL) {
        @CacheWrapper(url: url)
        var data
        if let data {
            image = UIImage(data: data)
        } else {
            DispatchQueue.global().async {
                do {
                    let fetchedData = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.image = UIImage(data: fetchedData)
                    }
                    data = fetchedData
                } catch {
                    dump(error)
                }
            }
        }
    }
    
    func setImage(with endpoint: EndpointRepresentable) {
        guard let url = endpoint.toURL() else { return }
        @CacheWrapper(url: url)
        var data
        if let data {
            image = UIImage(data: data)
        } else {
            DispatchQueue.global().async {
                do {
                    let fetchedData = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.image = UIImage(data: fetchedData)
                    }
                    data = fetchedData
                } catch {
                    dump(error)
                }
            }
        }
    }
}
