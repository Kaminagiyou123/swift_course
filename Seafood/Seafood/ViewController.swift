//
//  ViewController.swift
//  Seafood
//
//  Created by ran you on 2/6/22.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
//        imagePicker.sourceType = .camera
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
          }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

        self.imageView.image = userPickedImage
            guard let ciimage = CIImage(image:userPickedImage) else {
                fatalError(" Error converting UIimage into CIimage")
            }
            
            detect(image:ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    
    }
    
    func detect(image:CIImage) {
      guard let model = try? VNCoreMLModel(for: Inceptionv3().model)
        else {
            fatalError("Ladong CoreML Model Failed")
        }
        let request = VNCoreMLRequest(model:model){
            (request, error) in
            guard let results = request.results as? [VNClassificationObservation]
            else {
                fatalError ("Error getting model results")
            }
            
            if let firstResult = results.first {
                if firstResult.identifier.contains("Hotdog") {
                    self.navigationItem.title = "Hotdog"
                } else {
                    self.navigationItem.title = "Not Hotdog"
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage:image)
        do {
            try handler.perform ([request])
        } catch {
            print(error)
        }
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    
        present(imagePicker, animated: true, completion: nil)
    
    }
    
}

