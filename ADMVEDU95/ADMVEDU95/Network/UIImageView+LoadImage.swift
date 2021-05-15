//
//  UIImageView+loadImage.swift
//  FirstWorkProject
//
//  Created by Satsishur on 13.04.2021.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL) {
        let cache = NSCache<NSString, UIImage>()
        let cacheKey = NSString(string: url.absoluteString)

        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            if error != nil {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data)
            else {
                return
            }

            cache.setObject(image, forKey: cacheKey)

            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
