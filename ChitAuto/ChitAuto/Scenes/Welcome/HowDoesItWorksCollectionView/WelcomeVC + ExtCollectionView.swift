//
//  WelcomeVC + ExtCollectionView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import UIKit


extension WelcomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        welcomeViewModel.carRepairPhasesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //TODO: Fix
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhasesCell.identifier, for: indexPath) as! PhasesCell
        cell.configure(imageURL: URL(string: welcomeViewModel.carRepairPhases[indexPath.row].imageURL)!, phaseText: welcomeViewModel.carRepairPhases[indexPath.row].phaseText, phaseOrdinality: welcomeViewModel.carRepairPhases[indexPath.row].phaseOrdinality, firstStep: welcomeViewModel.carRepairPhases[indexPath.row].firstStep, secondStep: welcomeViewModel.carRepairPhases[indexPath.row].secondStep, thirdStep: welcomeViewModel.carRepairPhases[indexPath.row].thirdStep ?? "")
        return cell
    }
}

extension WelcomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = welcomeView.contentView.frame.width - 44
        let height: CGFloat = 570
        return CGSize(width: width, height: height)
    }
}
