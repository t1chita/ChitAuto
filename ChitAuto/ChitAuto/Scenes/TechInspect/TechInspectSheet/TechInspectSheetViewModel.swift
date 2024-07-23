//
//  TechInspectSheetViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 22.07.24.
//

import Foundation

final class TechInspectSheetViewModel {
    //MARK: - Properties
    let pastDate: String
    
    let futureDate: String
    
    //MARK: - Computed Properties
    var isInspectDateOverdue: Bool {
        pastDate == "ავტომობილი ვადაგადაცილებაშია"
    }
    
    //MARK: - Initialization
    init(pastDate: String, futureDate: String) {
        self.pastDate = pastDate
        self.futureDate = futureDate
    }
}
