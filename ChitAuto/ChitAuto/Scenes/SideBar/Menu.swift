//
//  Menu.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 20.07.24.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelectMenuItem(menuItem: MenuOptions)
}

enum MenuOptions: String, CaseIterable {
    case garage = "მანქანის შეკეთება"
    case techInspect = "ტექ ინსპექტირება"
    case orderHistory = "დასრულებული შეკვეთები"
    case profile = "პროფილი"
    case signOut = "გასვლა"
    
    var imageName: String {
        switch self {
        case .garage:
            "car.fill"
        case .techInspect:
            "gauge.open.with.lines.needle.67percent.and.arrowtriangle.and.car"
        case .profile:
            "person.fill"
        case .signOut:
            "rectangle.portrait.and.arrow.forward"
        case .orderHistory:
            "book.pages.fill"
        }
    }
}

final class MenuViewController: UIViewController {
    //MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    //MARK: - Delegates
    weak var menuViewControllerDelegate: MenuViewControllerDelegate?
    
    //MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBackground
        tableViewDelegates()
        setTableView()
    }
    
    private func tableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 230),
        ])
    }
}

//MARK: - TableView Extensions
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        menuViewControllerDelegate?.didSelectMenuItem(menuItem: item)
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.backgroundColor = .clear
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        if indexPath.row == MenuOptions.allCases.count - 1 {
            cell.textLabel?.textColor = .red
            cell.imageView?.tintColor = .red
        } else {
            cell.imageView?.tintColor = .customLabel
            cell.textLabel?.textColor = .customLabel
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOptions.allCases.count
    }
}
