//
//  FontsFactory.swift
//
//
//  Created by Arturo Murillo on 25/5/24.
//

import SwiftUI

public enum FontType {
    case bigTitle
    case largeTitle
    case title2
    case title3
    case body
    case headline
    case subheadline
    case caption2
    
    public var font: Font {
        switch self {
        case .bigTitle:
            return Font.system(size: 40, weight: .bold)
        case .largeTitle:
            return Font.system(size: 34, weight: .bold)
        case .title2:
            return Font.system(size: 22, weight: .regular)
        case .title3:
            return Font.system(size: 20, weight: .semibold)
        case .body:
            return Font.system(size: 17, weight: .regular)
        case .headline:
            return Font.system(size: 17, weight: .semibold)
        case .subheadline:
            return Font.system(size: 15, weight: .regular)
        case .caption2:
            return Font.system(size: 11, weight: .semibold)
        }
    }
}
