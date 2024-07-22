//
//  LocationSheetVC + ExtTableView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 17.07.24.
//

import UIKit

extension LocationSheetVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? LocationCell else { return }
        let selectedLocation = locationSheetViewModel.locations[indexPath.row]
        
        cell.isCellSelected = true
        cell.configure(withLocation: selectedLocation.localizedValue)
        
        if let previousIndexPath = locationSheetViewModel.previouslySelectedIndexPath, previousIndexPath != indexPath {
            guard let previousCell = tableView.cellForRow(at: previousIndexPath) as? LocationCell else { return }
            let previouslySelectedLocation = locationSheetViewModel.locations[previousIndexPath.row]
            
            previousCell.isCellSelected = false
            previousCell.configure(withLocation: previouslySelectedLocation.localizedValue)
        }
        
        locationSheetViewModel.previouslySelectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        locationSheetDelegate?.didSelectLocation(selectedLocation.localizedValue)
        self.dismiss(animated: true, completion: nil)
    }
}

extension LocationSheetVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locationSheetViewModel.locationsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.identifier, for: indexPath) as! LocationCell
        cell.configure(withLocation: locationSheetViewModel.locations[indexPath.row].localizedValue)
        return cell
    }
}
