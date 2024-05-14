//
//  CellForShowResults.swift
//  ParserMega
//
//  Created by Владислав Баранов on 05.05.2024.
//

import Foundation
import UIKit

class CellForShowResults : UICollectionViewCell {
    
    private let nameOfProduct : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Fulbo-Argenta", size: 15)
        label.textColor = .white
        label.numberOfLines = 4
        return label
        
    }()
    
    private let imageOfProduct : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private let startPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Fulbo-Argenta", size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let finalPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Fulbo-Argenta", size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        backgroundColor = .gray
        layer.cornerRadius = 10
        clipsToBounds = true
        
        
        addSubview(nameOfProduct)
        addSubview(startPrice)
        addSubview(finalPrice)
        addSubview(imageOfProduct)
        
        nameOfProduct.translatesAutoresizingMaskIntoConstraints = false
        startPrice.translatesAutoresizingMaskIntoConstraints = false
        finalPrice.translatesAutoresizingMaskIntoConstraints = false
        imageOfProduct.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            imageOfProduct.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageOfProduct.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageOfProduct.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageOfProduct.widthAnchor.constraint(equalTo: widthAnchor, constant: -16),
            imageOfProduct.heightAnchor.constraint(equalTo: imageOfProduct.widthAnchor),
            
            nameOfProduct.topAnchor.constraint(equalTo: imageOfProduct.bottomAnchor, constant: 8),
            nameOfProduct.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameOfProduct.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            startPrice.topAnchor.constraint(equalTo: nameOfProduct.bottomAnchor, constant: 8),
            startPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            startPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            finalPrice.topAnchor.constraint(equalTo: startPrice.bottomAnchor, constant: 8),
            finalPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            finalPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
    func configureResults(currentProduct : infoAboutProducts ) {
        loadImage(from: currentProduct.image){ image in
            if let image = image {
                self.imageOfProduct.image = image
            }
        }
        nameOfProduct.text = currentProduct.title
        startPrice.text = "Стартовая цена: \(currentProduct.price)"
        finalPrice.text = "Финальная цена: \(currentProduct.lastPrice)"
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    
}
