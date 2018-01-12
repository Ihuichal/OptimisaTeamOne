//
//  ViewController.swift
//  ExampleOne
//
//  Created by Ignacio Huichal on 10-01-18.
//  Copyright © 2018 Ignacio Huichal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //para saber que hacer con la foto luego de tomarla, utilizaremos delegados
    
    let imagepiker: UIImagePickerController = UIImagePickerController()
    
    @IBOutlet weak var viewImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hay que indicar que imagepicker va a responder al delegado
        imagepiker.delegate = self
        
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
      }
        //.....................//
    @IBAction func takePhoto(_ sender: AnyObject) {
        //Primero, saber si tenemos camara disponible
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //para utilizar la camara de atras
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil{
                imagepiker.allowsEditing = false
                imagepiker.sourceType = .camera
                imagepiker.cameraCaptureMode = .photo
            //ya configurado el imagepiker, tenemos que presentarlo
                present(imagepiker, animated: true, completion: nil)
            }
        }
        
    }
  
    @IBAction func selectPicGallery(_ sender: AnyObject) {
        //Funcion para mostrar archivos de la galeria
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagepiker.allowsEditing = false
            imagepiker.sourceType = .photoLibrary
            present(imagepiker, animated: true, completion: nil)
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imageSelect:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
           //se hace un casteo
            viewImage.image = imageSelect
            //guardar en libreria
            if imagepiker.sourceType == .camera{
            UIImageWriteToSavedPhotosAlbum(imageSelect, nil ,nil ,nil )
            }
        }else if let imageSelect = info[UIImagePickerControllerOriginalImage] as? UIImage {
            viewImage.image = imageSelect
        } else{
            print("Something went wrong")
        }
        
        dismiss(animated: true, completion: nil)
        //  imagepiker.dismiss(animated: true, completion: nil)
    }
}


