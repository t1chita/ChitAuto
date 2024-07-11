//
//  ModelsVC + ExtTableView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 11.07.24.
//

import UIKit

extension ModelsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ModelsCell else { return }
        let selectedCar = modelsViewModel.carModels[indexPath.row]
        
        cell.isCellSelected = true
        cell.configure(withCarBrand: selectedCar)
        modelsViewModel.savedCarModel = selectedCar
        
        if let previousIndexPath = modelsViewModel.previouslySelectedIndexPath, previousIndexPath != indexPath {
            guard let previousCell = tableView.cellForRow(at: previousIndexPath) as? ModelsCell else { return }
            let previouslySelectedCar = modelsViewModel.carModels[previousIndexPath.row]
            
            previousCell.isCellSelected = false
            previousCell.configure(withCarBrand: previouslySelectedCar)
        }
        
        modelsViewModel.previouslySelectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        modelsSheetsDelegate?.didSelectCarModel(selectedCar)
        self.dismiss(animated: true, completion: nil)
    }
}

extension ModelsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelsViewModel.carModelsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ModelsCell.identifier, for: indexPath) as! ModelsCell
        cell.configure(withCarBrand: modelsViewModel.carModels[indexPath.row])
        return cell
    }
}

