//
//  ViewController.swift
//  WhatFlower
//
//  Created by ran you on 2/7/22.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let wikipediaURl = "https://en.wikipedia.org/w/api.php"

    @IBOutlet weak var label: UILabel!
    
    
   let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion:nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage]
         as? UIImage
        
        { guard let convertedCIImage = CIImage (image: userPickedImage)
           else {
               fatalError("Can not convert UIImage to CIImage")
           }
           detect(image:convertedCIImage)
           
        imageView.image = userPickedImage as? UIImage
       }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image:CIImage) {
        guard let model = try? VNCoreMLModel(for:FlowerClassifier().model) else {
            fatalError("Can not import ML model")
        }
        
        let request  = VNCoreMLRequest (model:model) {
            (request, error) in
            guard  let classification = request.results?.first as? VNClassificationObservation else {
                fatalError("Could not classify Image")
            }
             
            self.navigationItem.title =  classification.identifier.capitalized
            self.requestinfo(flowerName: classification.identifier)
        }
            
        let handler = VNImageRequestHandler (ciImage:image)

            do {try handler.perform([request])}
            catch {print(error)}
        }
    
    func requestinfo (flowerName: String){
        
        let parameters : [String:String] = [
        "format" : "json",
        "action" : "query",
        "prop" : "extracts|pageimages",
        "exintro" : "",
        "explaintext" : "",
        "titles" : flowerName,
        "indexpageids" : "",
        "redirects" : "1",
        "pithumbsize" : "500"
        ]

        
        Alamofire.request( wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                print("got wikipedia result")
                print(response)
                
                let flowerJSON :JSON = JSON(response.result.value!)
                
                let pageId = flowerJSON["query"]["pageids"][0].stringValue
                
                let flowerDescription = flowerJSON["query"]["pages"][pageId]["extract"].stringValue
                
                let flowerImageURL = flowerJSON["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
                self.label.text = flowerDescription
                self.imageView.sd_setImage(with: URL(string:flowerImageURL))
            }
        }
    }
       
    }

 


  


