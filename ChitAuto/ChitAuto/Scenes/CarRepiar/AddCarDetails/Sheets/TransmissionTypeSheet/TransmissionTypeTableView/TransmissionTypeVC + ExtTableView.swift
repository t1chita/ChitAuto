//
//  TransmissionTypeVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//


import UIKit

extension TransmissionTypeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TransmissionTypeCell else { return }
        let selectedTransmissionType = transmissionTypeViewModel.transmissionTypes[indexPath.row]
        
        cell.isCellSelected = true
        cell.configure(withTransmissionType: selectedTransmissionType.localizedValue)
        
        if let previousIndexPath = transmissionTypeViewModel.previouslySelectedIndexPath, previousIndexPath != indexPath {
            guard let previousCell = tableView.cellForRow(at: previousIndexPath) as? TransmissionTypeCell else { return }
            let previouslySelectedTransmissionType = transmissionTypeViewModel.transmissionTypes[previousIndexPath.row]
            
            previousCell.isCellSelected = false
            previousCell.configure(withTransmissionType: previouslySelectedTransmissionType.localizedValue)
        }
        
        transmissionTypeViewModel.previouslySelectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        transmissionTypeViewModel.onTransmissionTypeChanged?(selectedTransmissionType.localizedValue)
        self.dismiss(animated: true, completion: nil)
    }
}

extension TransmissionTypeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transmissionTypeViewModel.transmissionTypesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransmissionTypeCell.identifier, for: indexPath) as! TransmissionTypeCell
        cell.configure(withTransmissionType: transmissionTypeViewModel.transmissionTypes[indexPath.row].localizedValue)
        return cell
    }
}

