//
//  TimeSheetVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 17.07.24.
//


import UIKit

final class TimeSheetVC: UIViewController {
    //MARK: - Properties
    var timeSheetView: TimeSheetView
    var timeSheetViewModel: TimeSheetViewModel
    
    //MARK: - Delegates
    weak var timeSheetDelegate: TimeSheetDelegate?
    
    //MARK: - Initialization
    init(timeSheetView: TimeSheetView, timeSheetViewModel: TimeSheetViewModel) {
        self.timeSheetView = timeSheetView
        self.timeSheetViewModel = timeSheetViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        view = timeSheetView
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
        timeSheetView.timeTableView.dataSource = self
        timeSheetView.timeTableView.delegate = self
    }
    
    //MARK: - Set UI Components

}
