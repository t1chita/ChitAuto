//
//  GarageSheetVC + ExtTableView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import UIKit

extension GarageSheetVC: UITableViewDelegate {
  //TODO: Add Selection
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


