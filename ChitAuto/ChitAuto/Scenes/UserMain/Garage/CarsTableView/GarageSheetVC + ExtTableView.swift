//
//  GarageSheetVC + ExtTableView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import UIKit

extension GarageSheetVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let lastIndexPath = garageSheetViewModel.lastSelectedIndexPath, let lastCell = tableView.cellForRow(at: lastIndexPath) as? CarCell {
            lastCell.setDeselectedAppearance()
        }
        
        if let currentCell = tableView.cellForRow(at: indexPath) as? CarCell {
            currentCell.setSelectedAppearance()
        }
        garageSheetViewModel.savedCar = garageSheetViewModel.userCars[indexPath.row]
        garageSheetViewModel.lastSelectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GarageSheetVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        garageSheetViewModel.userCarsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarCell.identifier, for: indexPath) as! CarCell
        cell.configure(withUserCar: garageSheetViewModel.userCars[indexPath.row])
        return cell
    }
}


