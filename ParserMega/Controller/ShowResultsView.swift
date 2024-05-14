//
//  ShowResults.swift
//  ParserMega
//
//  Created by Владислав Баранов on 05.05.2024.
//

import Foundation
import UIKit

class ShowResultsView : UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CellForShowResults.self, forCellWithReuseIdentifier: "cell")
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width / 2 - 16
        let height = view.bounds.height / 2 - 16
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfInfoProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellForShowResults
        cell.configureResults(currentProduct: arrayOfInfoProducts[indexPath.row])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showProduct(_:)))
        cell.addGestureRecognizer(tapGesture)
        return cell
    }
    
    //MARK: - Actions
    
    @objc private func showProduct(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? CellForShowResults else { return }
        let indexPath = collectionView.indexPath(for: cell)
        
        if let indexPath = indexPath {
            let urlString = arrayOfInfoProducts[indexPath.row].link
            let url = URL(string: urlString)
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
}

    
    

