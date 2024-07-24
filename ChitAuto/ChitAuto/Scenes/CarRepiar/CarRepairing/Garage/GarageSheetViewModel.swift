//
//  GarageSheetViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import Foundation


final class GarageSheetViewModel {
    //MARK: - Properties
    let userCars: [Car]
    
    var lastSelectedIndexPath: IndexPath?
    
    //MARK: - Computed Properties
    var userCarsCount: Int {
        userCars.count
    }
    
    var savedCar: Car? {
        didSet { onSavedCarChanged?(savedCar!)}
    }
    
    //MARK: - Closures
    var onSavedCarChanged: ((Car) -> Void)?
    
    //MARK: - LifeCycles
    init(userCars: [Car]) {
        self.userCars = userCars
    }
}
