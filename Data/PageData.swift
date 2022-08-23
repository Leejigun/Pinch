//
//  PageData.swift
//  Pinch
//
//  Created by bimo.ez on 2022/08/24.
//

import Foundation

enum PageNames: String, CaseIterable {
    case magazine_front_cover = "magazine-front-cover"
    case magazine_back_cover = "magazine-back-cover"
}

let pageData: [Page] = {
    return PageNames.allCases.enumerated()
        .map { index, pageName -> Page in
            return Page(id: index, imageName: pageName.rawValue)
        }
}()
