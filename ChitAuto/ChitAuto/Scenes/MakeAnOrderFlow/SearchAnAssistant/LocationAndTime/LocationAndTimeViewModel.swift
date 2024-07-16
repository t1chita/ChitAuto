//
//  LocationAndTimeViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 15.07.24.
//

import Foundation

final class LocationAndTimeViewModel {
    
    var cityLocation: String = "აირჩიე ქალაქი" {
        didSet { cityLocationChanged?(cityLocation) }
    }
    
    var timeValue: String = "აირჩიე დრო" {
        didSet { timeValueChanged?(timeValue) }
    }
    
    var cityLocationChanged: ((String) -> Void)?
    
    
    
    var timeValueChanged: ((String) -> Void)?
    
}
