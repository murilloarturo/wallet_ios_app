//
//  Mapper.swift
//  
//
//  Created by Arturo Murillo on 26/5/24.
//

import Foundation

public protocol Mapping<Input, Output> {
    associatedtype Input
    associatedtype Output
    func map(_ input: Input) -> Output
}
