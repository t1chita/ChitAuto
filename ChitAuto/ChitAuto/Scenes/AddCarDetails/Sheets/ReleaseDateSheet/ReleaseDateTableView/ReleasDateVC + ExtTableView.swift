//
//  ReleasDateVC + ExtTableView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 11.07.24.
//

import UIKit

extension ReleaseDateVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ReleaseDateCell else { return }
        let selectedYear = releaseDateViewModel.years[indexPath.row]
        
        cell.isCellSelected = true
        cell.configure(withReleaseDate: String(selectedYear))
        releaseDateViewModel.savedYear = selectedYear
        
        if let previousIndexPath = releaseDateViewModel.previouslySelectedIndexPath, previousIndexPath != indexPath {
            guard let previousCell = tableView.cellForRow(at: previousIndexPath) as? ReleaseDateCell else { return }
            let previouslySelectedYear = releaseDateViewModel.years[previousIndexPath.row]
            
            previousCell.isCellSelected = false
            previousCell.configure(withReleaseDate: String(previouslySelectedYear))
        }
        
        releaseDateViewModel.previouslySelectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        releaseDateSheetsDelegate?.didSelectCarModel(selectedYear)
        self.dismiss(animated: true, completion: nil)
    }
}

extension ReleaseDateVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        releaseDateViewModel.yearsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReleaseDateCell.identifier, for: indexPath) as! ReleaseDateCell
        cell.configure(withReleaseDate: String(releaseDateViewModel.years[indexPath.row]))
        return cell
    }
}


