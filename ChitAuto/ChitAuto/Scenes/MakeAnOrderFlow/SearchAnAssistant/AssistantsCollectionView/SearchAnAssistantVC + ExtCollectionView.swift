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
        cell.configure(withImageUrl: searchAnAssistantViewModel.filteredAssistants[indexPath.row].profilePicUrl, carBrands: searchAnAssistantViewModel.filteredAssistants[indexPath.row].carBrands, assistantName: searchAnAssistantViewModel.filteredAssistants[indexPath.row].fullName, servicePrice: String(searchAnAssistantViewModel.filteredAssistants[indexPath.row].assistantServiceFee), rating: String(searchAnAssistantViewModel.filteredAssistants[indexPath.row].rating))
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

