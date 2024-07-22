//
//  FuelTypeViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import Foundation
import Network

final class FuelTypeViewModel {
    private let fuelTypeApi: String = "https://chitauto-default-rtdb.europe-west1.firebasedatabase.app/fuelTypes.json"
    
    var previouslySelectedIndexPath: IndexPath?
        
    var fuelTypesCount: Int {
        fuelTypes.count
    }
    
    var fuelTypes: [FuelTypeResponse] = []
    
    init() {
        fetchFuelTypes()
    }
    
    //MARK: - Delegates
    weak var reloadDelegate: ReloadDelegate?
    
    private func fetchFuelTypes() {
        NetworkService.networkService.getData(urlString: fuelTypeApi) { [weak self] (result: Result<[FuelTypeResponse], Error>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let fuelTypeResponse):
                    self?.fuelTypes = fuelTypeResponse
                case .failure(let error):
                    print("DEBUG: Cann't Fetch Data From CARBRANDSAPI \(error.localizedDescription)")
                }
                self?.reloadDelegate?.reloadData()
            }
        }
    }
}
