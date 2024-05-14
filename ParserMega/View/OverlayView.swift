import Foundation
import UIKit

class OverlayView: UIViewController, UIPickerViewDelegate {
    
    var onClose: (() -> Void)?
    var rightValues =  Array(stride(from: 0, through: 100000, by: 1000))
    var leftValues = Array(stride(from: 0, through: 25000, by: 1000))
    var currentLeft = 0
    var currentRight = 0
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        
        //btns
        //closeButton
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .opaqueSeparator
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeOverlay), for: .touchUpInside)
        view.addSubview(closeButton)
        
        //submitButton
        let submitButton = UIButton(type: .custom)
        submitButton.setTitle("Подтвердить", for: .normal)
        submitButton.addTarget(self, action: #selector(addToList), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        
    
        NSLayoutConstraint.activate([
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.onClose?()
    }
    
    @objc func closeOverlay(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addToList(){
        closeOverlay()
    }
    
}
