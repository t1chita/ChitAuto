//
//  LocationAndTimeViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 15.07.24.
//

import Foundation

final class LocationAndTimeViewModel {
    var order: Order  {
        didSet { onCurrentOrderChanged?(order) }
    }

    var cityLocation: String {
        didSet {
            order.city = cityLocation
            cityLocationChanged?(cityLocation)
        }
    }

    var timeValue: String {
        didSet {
            order.time = timeValue
            timeValueChanged?(timeValue)
        }
    }

    var cityLocationChanged: ((String) -> Void)?
    var timeValueChanged: ((String) -> Void)?
    var onCurrentOrderChanged: ((Order) -> Void)?
    
    init(order: Order) {
        self.order = order
        self.cityLocation = order.city
        self.timeValue = order.time
    }
}
