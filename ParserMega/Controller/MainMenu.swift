//
//  mainMenu.swift
//  ParserMega
//
//  Created by Владислав Баранов on 04.05.2024.
//

import Foundation
import UIKit

class MainMenu : UIViewController{
    
    
    var currentPosOfPros = 0
    let primeProcent = [2, 5, 7, 9 , 12]
    var currentPrimeProcentPosition = 0
    
    private let containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let cellData = [
            (UIImage(systemName: "textformat"), "Запрос", "Что ищем?", UIColor(red: 65/255, green: 204/255, blue: 199/255, alpha: 1)),
            (UIImage(systemName: "list.dash"), "Промокоды", "\(listOfPromos.count) промокод", UIColor(red: 74/255, green: 154/255, blue: 207/255, alpha: 1)),
            (UIImage(systemName: "tag"), "Цена", "От \(priceFrom), до \(priceTo)", UIColor(red: 74/255, green: 117/255, blue: 170/255, alpha: 1)),
            (UIImage(systemName: "star"), "СберПрайм", "\(primeProcent[currentPrimeProcentPosition])%", UIColor(red: 92/255, green: 83/255, blue: 140/255, alpha: 1)),
            (UIImage(systemName: "magnifyingglass"), "Поиск", "2", UIColor(red: 88/255, green: 65/255, blue: 109/255, alpha: 1)),
        ]
        
        for data in cellData {
            let cell = createCell(image: data.0, firstText: data.1, secondText: data.2, backgroundColorInCell : data.3)
            containerView.addArrangedSubview(cell)
        }
    }
    

    
    private func createCell(image: UIImage?, firstText: String, secondText: String, backgroundColorInCell: UIColor?) -> CellForMainMenu {
        let cell = CellForMainMenu()
        cell.configure(image: image, firstText: firstText, secondText: secondText)
        cell.backgroundColor = backgroundColorInCell
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCellTap(_:)))
        cell.addGestureRecognizer(tapGesture)
        return cell
    }
    
    
    //MARK: - Actions
    @objc private func handleCellTap(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? CellForMainMenu else { return }
        let index = containerView.arrangedSubviews.firstIndex(of: cell)
        switch index {
        case 0 : enterRequest()
        case 1 : showPromo()
        case 2 : pickPrice()
        case 3 : workWithProcent()
        case 4 :
            if findigProduct != "" {
                reboot()
                configureURL()
                presentController()
            } else {
                let alertController = UIAlertController(title: "Введите запрос", message: nil, preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "Ок", style: .default)
                alertController.addAction(confirmAction)
                present(alertController, animated: true, completion: nil)
            }
        case .none: break
        case .some(_): break
        }
    }

    func enterRequest(){
        reboot()
        let alertController = UIAlertController(title: "Введите запрос", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Введите текст"
        }
        
        let confirmAction = UIAlertAction(title: "Подтвердить", style: .default) { _ in [self]
            if let text = alertController.textFields?.first?.text {
                findigProduct = text
                self.updateSecondLabel(index: 0, newText: text)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func showPromo(){
        let viewOfPromocods = ListPromocods()
        print("smth")
        navigationController?.pushViewController(viewOfPromocods, animated: true)
      //  present(viewOfPromocods, animated: true)
        viewOfPromocods.onClose = {
            print("Кложур")
            self.updateSecondLabel(index: 1, newText: "\(listOfPromos.count) промокод")
        }
    }
    
    func pickPrice() {
        let controller = OverlayViewPickPrice()
        if let sheetController = controller.sheetPresentationController {
            sheetController.detents = [.medium()]
        }
        present(controller, animated: true)
        controller.onClose = {
            print("Closure")
            self.updateSecondLabel(index: 2, newText: "От \(priceFrom), до \(priceTo)")
        }
    }
    
    func workWithProcent(){
        currentPrimeProcentPosition += 1
        if currentPrimeProcentPosition >= primeProcent.count {
            currentPrimeProcentPosition = currentPrimeProcentPosition-primeProcent.count
        }
        
        currentPrime = primeProcent[currentPrimeProcentPosition]
        updateSecondLabel(index: 3, newText: "\(primeProcent[currentPrimeProcentPosition])%")
    }
    
    func presentController(){

        currentArr = arrayOfInfoProducts.count
        print(startURL)
        var controller = ViewController()
        present(controller, animated: true)
        addPage()
        controller.onClose = {
            if currentPage < 9 {
                self.presentController()
            } else {
                workingWithArrayOfData()
                print(arrayOfInfoProducts)
                self.showResults()
            }
        }
        controller.nilContent = {
            workingWithArrayOfData()
            print(arrayOfInfoProducts)
            self.showResults()
        }
    }


    
    func showResults(){
        let controller = ShowResultsView()
        present(controller, animated: true)
    }
    
    //MARK: - Update stackView element
    func updateSecondLabel(index : Int, newText: String){
        if let cellToUpdate = containerView.arrangedSubviews[index] as? CellForMainMenu {
            cellToUpdate.secondTextLabel.text = newText
        }
    }
    
}

