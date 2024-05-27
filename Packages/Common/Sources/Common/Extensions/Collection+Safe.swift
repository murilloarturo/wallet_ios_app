//
//  Collection+Safe.swift
//
//
//  Created by Arturo Murillo on 27/5/24.
//

import Foundation

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
