//
//  ReleaseDateViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 11.07.24.
//

import Foundation

final class ReleaseDateViewModel {
    //MARK: - Properties
    let years: [Int] = Array(1990...2024)
    
    var previouslySelectedIndexPath: IndexPath?
    
    //MARK: - Computed Properties
    var yearsCount: Int {
        years.count
    }
    
    //MARK: - Closures
    var onReleaseDateChanged: ((Int) -> Void)?
}
