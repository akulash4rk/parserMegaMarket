//
//  UnderlinedTextFild.swift
//  ParserMega
//
//  Created by Владислав Баранов on 06.05.2024.
//

import Foundation
import UIKit
class UnderlinedTextField: UITextField {
    private let underline = CALayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUnderline()
        configureKeyboard()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUnderline()
        configureKeyboard()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUnderlineFrame()
    }
    private func setupUnderline() {
        borderStyle = .none
        underline.backgroundColor = UIColor.white.cgColor
        layer.addSublayer(underline)
    }
    private func updateUnderlineFrame() {
        underline.frame = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: 1)
    }
    private func configureKeyboard() {
        keyboardType = .numberPad
    }
}
