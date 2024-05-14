//
//  ListPromocods.swift
//  ParserMega
//
//  Created by Владислав Баранов on 23.04.2024.
//
import Foundation
import UIKit

var listOfOutputs: [String] = []



class ListPromocods: UITableViewController{
    
    var onClose: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tablePromocods = UITableView()
        view.addSubview(tablePromocods)
        
        NSLayoutConstraint.activate([
            tablePromocods.topAnchor.constraint(equalTo: view.topAnchor),
            tablePromocods.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tablePromocods.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tablePromocods.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tablePromocods.delegate = self
        tablePromocods.dataSource = self
        
        let addElementButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addElement))
        addElementButton.tintColor = UIColor(red: 74/255, green: 154/255, blue: 207/255, alpha: 1)
        self.navigationItem.rightBarButtonItem = addElementButton
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 74/255, green: 154/255, blue: 207/255, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.onClose?()
    }
    
    //MARK: - TableView
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listOfPromos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPromos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "promoCell")
        cell.textLabel?.text = "Скидка \(listOfPromos[indexPath.row].1) от \(listOfPromos[indexPath.row].0)"
        cell.textLabel?.textColor = UIColor(red: 74/255, green: 154/255, blue: 207/255, alpha: 1)
        return cell
    }
    
    //MARK: - Actions
    @objc func addElement() {
        let controller = OverlayViewPickerPromo()
        controller.onClose = { [weak self] in
               self?.tableView.reloadData()
           }
        if let sheetController = controller.sheetPresentationController {
            sheetController.detents = [.medium()]
        }
        
        present(controller, animated: true)
    }
}
