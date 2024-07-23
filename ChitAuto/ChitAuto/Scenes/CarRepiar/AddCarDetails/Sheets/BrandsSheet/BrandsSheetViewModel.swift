//
//  BrandsAndModelsSheetViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 10.07.24.
//

import Foundation
import Network

final class BrandsSheetViewModel {
    //MARK: - Properties
    var carBrands: [CarBrand] = []
    var previouslySelectedIndexPath: IndexPath?
        
    //MARK: - Computed Properties
    var carBrandsCount: Int {
        carBrands.count
    }
    
    //MARK: - Closures
    var onBrandsChanged: ((CarBrand) -> Void)?
    
    //MARK: - Api Urls
    private let carBrandsApi: String = "https://chitauto-default-rtdb.europe-west1.firebasedatabase.app/carBrands.json"
    
    //MARK: - Initialization
    init() {
        fetchCarBrands()
    }
    
    //MARK: - Delegates
    weak var reloadDelegate: ReloadDelegate?
    
    //MARK: - Fetching Methods
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
