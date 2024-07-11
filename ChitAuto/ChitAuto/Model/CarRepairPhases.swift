//
//  CarRepairPhases.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import Foundation

struct CarRepairPhases: Decodable {
    let phases: [RepairPhase]
}

struct RepairPhase: Decodable {
    let firstStep: String
    let imageURL: String
    let phaseOrdinality: String
    let phaseText: String
    let secondStep: String
    let thirdStep: String?
}
