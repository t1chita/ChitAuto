//
//  TransmissionTypeViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import Foundation
import Network

final class TransmissionTypeViewModel {
    //MARK: Properties
    var previouslySelectedIndexPath: IndexPath?
    
    var transmissionTypes: [TransmissionTypesResponse] = []
        
    //MARK: - Computed Properties
    var transmissionTypesCount: Int {
        transmissionTypes.count
    }
    
    //MARK: - Closures
    var onTransmissionTypeChanged: ((String) -> Void)?
    
    //MARK: - Api Urls
    private let transmissionTypeApi: String = "https://chitauto-default-rtdb.europe-west1.firebasedatabase.app/transmissionTypes.json"
    
    //MARK: - Initialization
    init() {
        fetchTransmissionTypes()
    }
    
    //MARK: - Delegates
    weak var reloadDelegate: ReloadDelegate?
    
    //MARK: - Fetching Methods
    private func fetchTransmissionTypes() {
        NetworkService.networkService.getData(urlString: transmissionTypeApi) { [weak self] (result: Result<[TransmissionTypesResponse], Error>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let transmissionTypesResponse):
                    self?.transmissionTypes = transmissionTypesResponse
                case .failure(let error):
                    print("DEBUG: Cann't Fetch Data From CARBRANDSAPI \(error.localizedDescription)")
                }
                self?.reloadDelegate?.reloadData()
            }
        }
    }
}
