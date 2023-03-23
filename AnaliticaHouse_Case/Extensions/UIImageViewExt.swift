//
//  UIImageViewExt.swift
//  AnaliticaHouse_Case
//
//  Created by Ahmet ALTINTOP on 22.03.2023.
//

import Foundation
import UIKit

extension UIImageView {   /// API'den gelen imageURL'i teşhir etmek için . .
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
