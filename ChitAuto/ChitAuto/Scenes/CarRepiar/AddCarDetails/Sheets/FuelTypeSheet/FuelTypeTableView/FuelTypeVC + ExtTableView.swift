//
//  FuelTypeVC + ExtTableView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import UIKit

extension FuelTypeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FuelTypeCell else { return }
        let selectedFuelType = fuelTypeViewModel.fuelTypes[indexPath.row]
        
        cell.isCellSelected = true
        cell.configure(withFuelType: selectedFuelType.localizedValue)
        
        if let previousIndexPath = fuelTypeViewModel.previouslySelectedIndexPath, previousIndexPath != indexPath {
            guard let previousCell = tableView.cellForRow(at: previousIndexPath) as? FuelTypeCell else { return }
            let previouslySelectedFuelType = fuelTypeViewModel.fuelTypes[previousIndexPath.row]
            
            previousCell.isCellSelected = false
            previousCell.configure(withFuelType: previouslySelectedFuelType.localizedValue)
        }
        
        fuelTypeViewModel.previouslySelectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        fuelTypeSheetDelegate?.didSelectFuelType(selectedFuelType.localizedValue)
        self.dismiss(animated: true, completion: nil)
    }
}

extension FuelTypeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fuelTypeViewModel.fuelTypesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FuelTypeCell.identifier, for: indexPath) as! FuelTypeCell
        cell.configure(withFuelType: fuelTypeViewModel.fuelTypes[indexPath.row].localizedValue)
        return cell
    }
}



