//
//  FetchableImageView.swift
//  Mobile2YouChallenge
//
//  Created by Gabriel Souza de Araujo on 06/01/22.
//

import UIKit
fileprivate let imageCache = NSCache<AnyObject, UIImage>()
class FetchableImageView: UIImageView {
    var task: URLSessionDataTask?
    let loadSpinner = UIActivityIndicatorView(style: .medium)
    
    private func addSpinner() {
        addSubview(loadSpinner)
        loadSpinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadSpinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadSpinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.loadSpinner.startAnimating()
        }
        
    }
    
    private func removeSpinner() {
        loadSpinner.removeFromSuperview()
    }
    
    func getImage(from imagePath: String) {
        image = nil
        addSpinner()
        guard let url = URL(string: "https://image.tmdb.org/t/p/original\(imagePath)") else {
            print("Error to get url from image path: \(imagePath)")
            return
        }
        
        task?.cancel()
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) {
            removeSpinner()
            image = imageFromCache
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let self = self,
                error == nil,
                let data = data,
                let image = UIImage(data: data)
            else {
                    print("Error to get image from url: \(url)")
                    return
            }
            
            imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.removeSpinner()
                self.image = image
            }
        }
        task?.resume()
    }
}
