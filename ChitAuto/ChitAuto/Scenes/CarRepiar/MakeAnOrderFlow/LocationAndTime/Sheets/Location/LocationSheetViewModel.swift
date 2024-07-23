//
//  LocationSheetViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 17.07.24.
//

import Foundation
import Network

final class LocationSheetViewModel {
    //MARK: - Properties
    var locations: [LocationResponse] = []
    
    var previouslySelectedIndexPath: IndexPath?
    
    //MARK: - Computed Properties
    var locationsCount: Int {
        locations.count
    }
    
    //MARK: - Api Urls
    private let locationApi: String = "https://chitauto-default-rtdb.europe-west1.firebasedatabase.app/locations.json"
    
    //MARK: - Initialization
    init() {
        fetchLocations()
    }
    
    //MARK: - Delegates
    weak var reloadDelegate: ReloadDelegate?
    
    //MARK: - Fetching Methods
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
