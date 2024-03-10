//
//  ImageManager.swift
//  appStoreSearch
//
//  Created by siyeon park on 2023/08/14.
//

import Foundation
import Moya

class ImageManager {
    static let shared = ImageManager()

    private init() {}

    func loadImage(with urlString: String, into imageView: UIImageView, placeholder: UIImage? = nil) {

        guard let url = URL(string: urlString) else { return }

        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) { result in
                switch result {
                case .success(let value):
                    print("Task done")
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
    }
}
