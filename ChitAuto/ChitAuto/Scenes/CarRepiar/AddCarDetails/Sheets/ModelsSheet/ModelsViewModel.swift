//
//  ModelsViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 11.07.24.
//

import Foundation
import Network

final class ModelsViewModel {
    private let modelsApi = "https://new-api.caru.ge/v1/cars/brand-models?CarBrandId="
    
    var previouslySelectedIndexPath: IndexPath?
    
    var carBrandId: Int
        
    var carModelsCount: Int {
        carModels.count
    }
    
    var carModels: [CarModel] = []
    
    init(carBrandId: Int) {
        self.carBrandId = carBrandId
        fetchModels()
    }
    
    weak var reloadDelegate: ReloadDelegate?
    
    private func fetchModels() {
        NetworkService.networkService.getData(urlString: modelsApi + String(carBrandId)) { [weak self] (result: Result<CarModelsResponse, Error>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let carModelsResponse):
                    self?.carModels = carModelsResponse.carModels
                case .failure(let error):
                    print("DEBUG: Cann't Fetch Car Models \(error.localizedDescription)")
                }
                self?.reloadDelegate?.reloadData()
            }
        }
    }
}
