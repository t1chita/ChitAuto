//
//  LocationSheetViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 17.07.24.
//

import Foundation
import Network

final class LocationSheetViewModel {
    private let locationApi: String = "https://chitauto-default-rtdb.europe-west1.firebasedatabase.app/locations.json"
    
    var previouslySelectedIndexPath: IndexPath?
        
    var locationsCount: Int {
        locations.count
    }
    
    var locations: [LocationResponse] = []
    
    init() {
        fetchLocations()
    }
    
    //MARK: - Delegates
    weak var reloadDelegate: ReloadDelegate?
    
    private func fetchLocations() {
        NetworkService.networkService.getData(urlString: locationApi) { [weak self] (result: Result<[LocationResponse], Error>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let locations):
                    self?.locations = locations
                case .failure(let error):
                    print("DEBUG: Cann't Fetch Data From CARBRANDSAPI \(error.localizedDescription)")
                }
                self?.reloadDelegate?.reloadData()
            }
        }
    }
}
