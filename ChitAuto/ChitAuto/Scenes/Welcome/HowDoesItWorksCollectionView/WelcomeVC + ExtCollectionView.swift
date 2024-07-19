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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhasesCell.identifier, for: indexPath) as! PhasesCell
        cell.configure(withRepairPhase: welcomeViewModel.carRepairPhases[indexPath.row])
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
