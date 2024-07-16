//
//  SearchAnAssistantVC + ExtCollectionView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 16.07.24.
//

import UIKit


extension SearchAnAssistantVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchAnAssistantViewModel.assistantsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssistantsCell.identifier, for: indexPath) as! AssistantsCell
        cell.configure(withAssistantInfo: searchAnAssistantViewModel.filteredAssistants[indexPath.row])
        return cell
    }
}

extension SearchAnAssistantVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = searchAnAssistantView.carInfoBackground.frame.width - 120
        let height: CGFloat = 250
        return CGSize(width: width, height: height)
    }
}

