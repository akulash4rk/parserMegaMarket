//
//  cellForMainMenu.swift
//  ParserMega
//
//  Created by Владислав Баранов on 04.05.2024.
//

import Foundation
import UIKit

class CellForMainMenu : UIView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private let firstTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Fulbo-Argenta", size: 35)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let secondTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Fulbo-Argenta", size: 25)
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
        addSubview(imageView)
        addSubview(firstTextLabel)
        addSubview(secondTextLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        firstTextLabel.translatesAutoresizingMaskIntoConstraints = false
        secondTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false

        
        
        
        NSLayoutConstraint.activate([
            
          
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, constant: -16),
            
            firstTextLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            firstTextLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            firstTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            secondTextLabel.topAnchor.constraint(equalTo: firstTextLabel.bottomAnchor, constant: 8),
            secondTextLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            secondTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func configure(image: UIImage?, firstText: String, secondText: String) {
        imageView.image = image
        firstTextLabel.text = firstText
        secondTextLabel.text = secondText
    }
}
