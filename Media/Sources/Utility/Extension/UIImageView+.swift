//
//  UIImageView+.swift
//  Media
//
//  Created by gnksbm on 6/25/24.
//

import UIKit

extension UIImageView {
    @discardableResult
    func setImage(with url: URL) -> URLSessionTask? {
        @CacheWrapper(url: url)
        var data
        if let data {
            image = UIImage(data: data)
            return nil
        } else {
            let task = URLSession.shared.dataTask(
                with: url
            ) { fetchedData, response, error in
                if let fetchedData {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: fetchedData)
                    }
                    data = fetchedData
                }
            }
            task.resume()
            return task
        }
    }
    
    @discardableResult
    func setImage(with endpoint: EndpointRepresentable) -> URLSessionTask? {
        guard let url = endpoint.toURL() else { return nil }
        return setImage(with: url)
    }
}
