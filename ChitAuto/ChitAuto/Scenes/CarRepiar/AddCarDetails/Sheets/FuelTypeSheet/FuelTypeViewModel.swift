//
//  FuelTypeViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import Foundation
import Network

final class FuelTypeViewModel {
    //MARK: - Properties
    var previouslySelectedIndexPath: IndexPath?
    
    var fuelTypes: [FuelTypeResponse] = []
        
    //MARK: - Computed Properties
    var fuelTypesCount: Int {
        fuelTypes.count
    }
    
    //MARK: - Closures
    var onFuelTypeChanged: ((String) -> Void)?
    
    //MARK: - Api Urls
    private let fuelTypeApi: String = "https://chitauto-default-rtdb.europe-west1.firebasedatabase.app/fuelTypes.json"
    
    //MARK: - Initialization
    init() {
        fetchFuelTypes()
    }
    
    //MARK: - Delegates
    weak var reloadDelegate: ReloadDelegate?
    
    //MARK: - Fetching Methods
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
