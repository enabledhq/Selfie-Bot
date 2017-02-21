//
//  ViewController.swift
//  Selfie-Bot
//
//  Created by Simeon on 17/2/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import UIKit
import SnapKit
import AWSRekognition

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let cameraButton = UIButton()
    private let selfieBotView = SelfieBotView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        
        let gradient = GradientView(gradient: PXPGradientColor(startingColor: UIColor(white: 0.0, alpha: 0.6), endingColor: UIColor(white: 0.0, alpha: 0.0)), frame: .zero)
        gradient.angle = 90.0
        
        view.addSubview(gradient)
        
        gradient.snp.makeConstraints {
            make in
            
            make.left.top.right.equalTo(0)
            make.bottom.equalTo(view.snp.centerY)
        }
        
        view.addSubview(cameraButton)
        
        cameraButton.setTitle("PICS!", for: .normal)
        cameraButton.backgroundColor = .black
        cameraButton.layer.cornerRadius = 5
        cameraButton.snp.makeConstraints {
            make in
            
            make.bottom.equalTo(0).inset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        
        cameraButton.addTarget(self, action: #selector(cameraButtonPressed(_:)), for: .touchUpInside)
        
        view.addSubview(selfieBotView)
        
        selfieBotView.snp.makeConstraints {
            make in
            
            make.edges.equalTo(0)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(tap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(viewDoubleTapped(_:)))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
    }
    
    //MARK: - Actions

    @objc private func viewTapped(_ sender: UITapGestureRecognizer) {
        
        let point = sender.location(in: view)
        
        //TODO: point should be converted to selfieBotView coords, but doesn't make a difference in this instance
        
        selfieBotView.lookAt(point: point)        
    }
    
    @objc private func viewDoubleTapped(_ sender: UITapGestureRecognizer) {
        
        selfieBotView.speakWords(wordCount: 3)
    }
    
    @objc private func cameraButtonPressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Image Picker Delegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            selfieBotView.setSnapImage(image.normalizeOrientation())
            
            let data = UIImageJPEGRepresentation(image, 0.7)
            let request = AWSRekognitionDetectFacesRequest()
            let image = AWSRekognitionImage()
            image?.bytes = data
            request?.image = image
            AWSRekognition.default().detectFaces(request!).continueOnSuccessWith {
                $0.result?.faceDetails?.forEach {
                    print($0.confidence!)
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Status Bar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

