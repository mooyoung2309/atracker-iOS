//
//  ViewModel.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
