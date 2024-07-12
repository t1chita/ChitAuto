//
//  BrandsAndModelsSheetVC + ExtTableView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 10.07.24.
//

import UIKit

extension BrandsSheetsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BrandsCell else { return }
        let selectedCar = brandsSheetViewModel.carBrands[indexPath.row]
        
        cell.isCellSelected = true
        cell.configure(withCarBrand: selectedCar)
        
        if let previousIndexPath = brandsSheetViewModel.previouslySelectedIndexPath, previousIndexPath != indexPath {
            guard let previousCell = tableView.cellForRow(at: previousIndexPath) as? BrandsCell else { return }
            let previouslySelectedCar = brandsSheetViewModel.carBrands[previousIndexPath.row]
            
            previousCell.isCellSelected = false
            previousCell.configure(withCarBrand: previouslySelectedCar)
        }
        
        brandsSheetViewModel.previouslySelectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        brandsSheetsDelegate?.didSelectCarBrand(selectedCar)
        self.dismiss(animated: true, completion: nil)
    }
}

extension BrandsSheetsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        brandsSheetViewModel.carBrandsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BrandsCell.identifier, for: indexPath) as! BrandsCell
        cell.configure(withCarBrand: brandsSheetViewModel.carBrands[indexPath.row])
        return cell
    }
}
