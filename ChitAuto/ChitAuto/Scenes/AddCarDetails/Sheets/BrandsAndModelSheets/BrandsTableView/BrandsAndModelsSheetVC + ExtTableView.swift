//
//  BrandsAndModelsSheetVC + ExtTableView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 10.07.24.
//

import UIKit

extension BrandsAndModelsSheetsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BrandsCell else { return }
        let selectedCar = brandsAndModelsSheetViewModel.carBrands[indexPath.row]
        
        cell.isCellSelected = true
        cell.configure(withCarBrand: selectedCar)
        brandsAndModelsSheetViewModel.savedCarBrand = selectedCar
        
        if let previousIndexPath = brandsAndModelsSheetViewModel.previouslySelectedIndexPath, previousIndexPath != indexPath {
            guard let previousCell = tableView.cellForRow(at: previousIndexPath) as? BrandsCell else { return }
            let previouslySelectedCar = brandsAndModelsSheetViewModel.carBrands[previousIndexPath.row]
            
            previousCell.isCellSelected = false
            previousCell.configure(withCarBrand: previouslySelectedCar)
        }
        
        brandsAndModelsSheetViewModel.previouslySelectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        brandsAndModelsSheetsDelegate?.didSelectCarBrand(selectedCar)
        self.dismiss(animated: true, completion: nil)
    }
}

extension BrandsAndModelsSheetsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        brandsAndModelsSheetViewModel.carBrandsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BrandsCell.identifier, for: indexPath) as! BrandsCell
        cell.configure(withCarBrand: brandsAndModelsSheetViewModel.carBrands[indexPath.row])
        return cell
    }
}
