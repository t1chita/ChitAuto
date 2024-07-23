//
//  TimeSheetViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 17.07.24.
//

import Foundation

final class TimeSheetViewModel {
    //MARK: - Properties
    let times: [String] = ["დილით", "შუადღით", "საღამოს"]
    
    var previouslySelectedIndexPath: IndexPath?
    
    //MARK: - Computed Properties
    var timesCount: Int {
        times.count
    }
}
