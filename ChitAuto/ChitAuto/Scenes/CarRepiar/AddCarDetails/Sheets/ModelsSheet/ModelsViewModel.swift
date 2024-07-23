//
//  ModelsViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 11.07.24.
//

import Foundation
import Network

final class ModelsViewModel {
    //MARK: - Properties
    var carModels: [CarModel] = []
    
    var previouslySelectedIndexPath: IndexPath?
    
    var carBrandId: Int
        
    //MARK: - Computed Properties
    var carModelsCount: Int {
        carModels.count
    }
    
    //MARK: - Closures
    var onModelsChanged: ((String) -> Void)?

    //MARK: - Api Urls
    private let modelsApi = "https://new-api.caru.ge/v1/cars/brand-models?CarBrandId="
    
    //MARK: - Initialization
    init(carBrandId: Int) {
        self.carBrandId = carBrandId
        fetchModels()
    }
    
    //MARK: - Delegates
    weak var reloadDelegate: ReloadDelegate?
   
    //MARK: - Fetching Methods
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
