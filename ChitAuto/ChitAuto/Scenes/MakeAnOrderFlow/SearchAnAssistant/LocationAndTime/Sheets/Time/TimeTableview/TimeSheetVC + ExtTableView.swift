//
//  TimeSheetVC + ExtTableView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 17.07.24.
//

import UIKit

extension TimeSheetVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TimeCell else { return }
        let selectedTime = timeSheetViewModel.times[indexPath.row]
        
        cell.isCellSelected = true
        cell.configure(withTime: selectedTime)
        
        if let previousIndexPath = timeSheetViewModel.previouslySelectedIndexPath, previousIndexPath != indexPath {
            guard let previousCell = tableView.cellForRow(at: previousIndexPath) as? TimeCell else { return }
            let previouslySelectedTime = timeSheetViewModel.times[previousIndexPath.row]
            
            previousCell.isCellSelected = false
            previousCell.configure(withTime: previouslySelectedTime)
        }
        
        timeSheetViewModel.previouslySelectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        timeSheetDelegate?.didSelectTime(selectedTime)
        self.dismiss(animated: true, completion: nil)
    }
}

extension TimeSheetVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timeSheetViewModel.timesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeCell.identifier, for: indexPath) as! TimeCell
        cell.configure(withTime: timeSheetViewModel.times[indexPath.row])
        return cell
    }
}

