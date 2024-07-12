//
//  BrandsAndModelsSheetViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 10.07.24.
//

import Foundation
import Network

final class BrandsSheetViewModel {
    private let carBrandsApi: String = "https://chitauto-default-rtdb.europe-west1.firebasedatabase.app/carBrands.json"
    
    var previouslySelectedIndexPath: IndexPath?
        
    var carBrandsCount: Int {
        carBrands.count
    }
    
    var carBrands: [CarBrand] = []
    
    init() {
        fetchCarBrands()
    }
    
    //MARK: - Delegates
    weak var reloadDelegate: ReloadDelegate?
    
    private func fetchCarBrands() {
        NetworkService.networkService.getData(urlString: carBrandsApi) { [weak self] (result: Result<CarBrandsResponse, Error>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let carBrandsResponse):
                    self?.carBrands = carBrandsResponse.carBrands
                case .failure(let error):
                    print("DEBUG: Cann't Fetch Data From CARBRANDSAPI \(error.localizedDescription)")
                }
                self?.reloadDelegate?.reloadData()
            }
        }
    }
}
