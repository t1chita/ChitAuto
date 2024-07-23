//
//  LocationAndTimeViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 15.07.24.
//

import Foundation

final class LocationAndTimeViewModel {
    //MARK: - Properties
    let userId: String
    
    //MARK: - Computed Properties
    var order: Order  {
        didSet { onCurrentOrderChanged?(order) }
    }

    var cityLocation: String = "აირჩიე ქალაქი" {
        didSet {
            order.city = cityLocation
            cityLocationChanged?(cityLocation)
        }
    }
    
    var address: String = "" {
        didSet { order.address = address }
    }
    
    var date: String = "" {
        didSet { order.date = date }
    }
    
    var timeValue: String = "აირჩიე დრო" {
        didSet {
            order.time = timeValue
            timeValueChanged?(timeValue)
        }
    }

    //MARK: - Closures
    var cityLocationChanged: ((String) -> Void)?
    var timeValueChanged: ((String) -> Void)?
    var onCurrentOrderChanged: ((Order) -> Void)?
    
    //MARK: - Initialization
    init(order: Order, userId: String) {
        self.order = order
        self.userId = userId
    }
}

//MARK: - Validation
extension LocationAndTimeViewModel {
    private var isCityValid: Bool {
        cityLocation != "აირჩიე ქალაქი"
    }
    
    private var isAddressValid: Bool {
        address != ""
    }
    
    private var isDateValid: Bool {
        date != ""
    }
    
    private var isTimeValid: Bool {
        timeValue != "აირჩიე დრო"
    }
    
    var isLocationAndTimeFormValid: Bool {
        return isCityValid
        && isAddressValid
        && isDateValid
        && isTimeValid
    }
}
