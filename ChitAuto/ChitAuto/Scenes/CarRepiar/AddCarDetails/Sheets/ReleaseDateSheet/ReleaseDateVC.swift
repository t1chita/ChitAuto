//
//  ReleaseDateVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 11.07.24.
//

import UIKit

final class ReleaseDateVC: UIViewController {
    //MARK: - Properties
    var releaseDateView: ReleaseDateView
    var releaseDateViewModel: ReleaseDateViewModel
    
    //MARK: - Delegates
    weak var releaseDateSheetsDelegate: ReleaseDateSheetsDelegate?
    
    //MARK: - Initialization
    init(releaseDateView: ReleaseDateView, releaseDateViewModel: ReleaseDateViewModel) {
        self.releaseDateView = releaseDateView
        self.releaseDateViewModel = releaseDateViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        view = releaseDateView
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleDelegates()
    }
    //MARK: - Setup UI
    
    //MARK: - Delegates
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        releaseDateView.releaseDateTableView.dataSource = self
        releaseDateView.releaseDateTableView.delegate = self
    }
    
    //MARK: - Set UI Components

}
