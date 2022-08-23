//
//  Page.swift
//  Pinch
//
//  Created by bimo.ez on 2022/08/24.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
    
    internal init(id: Int, imageName: String) {
        self.id = id
        self.imageName = imageName
    }
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
