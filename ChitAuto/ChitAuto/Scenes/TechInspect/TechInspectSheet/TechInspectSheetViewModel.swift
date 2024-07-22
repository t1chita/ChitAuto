//
//  TechInspectSheetViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 22.07.24.
//

import Foundation

final class TechInspectSheetViewModel {
    let pastDate: String
    let futureDate: String
    
    var isInspectDateOverdue: Bool {
        pastDate == "ავტომობილი ვადაგადაცილებაშია"
    }
    
    init(pastDate: String, futureDate: String) {
        self.pastDate = pastDate
        self.futureDate = futureDate
    }
}
