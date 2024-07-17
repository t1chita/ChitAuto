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

    var cityLocationChanged: ((String) -> Void)?
    var timeValueChanged: ((String) -> Void)?
    var onCurrentOrderChanged: ((Order) -> Void)?
    
    init(order: Order) {
        self.order = order
    }
}
