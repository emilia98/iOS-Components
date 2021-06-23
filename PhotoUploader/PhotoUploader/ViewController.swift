//
//  ViewController.swift
//  PhotoUploader
//
//  Created by Emilia Nedyalkova on 23.06.21.
//

import UIKit
import FirebaseStorage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    private let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.numberOfLines = 0
        label.textAlignment = .center
        imageView.contentMode = .scaleAspectFit
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else {
            return
        }
        
        label.text = urlString
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, urlResponse, error in
            guard let data = data, error == nil else {
                return
            }
            
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
            
        })
        
        task.resume()
    }
    
    @IBAction func didTapButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        guard let imageData = image.pngData() else {
            return
        }
        
        let imageURL = "images/file_\(Date().timeIntervalSince1970).png"
        
        storage.child(imageURL).putData(imageData, metadata: nil, completion: { _, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            
            self.storage.child(imageURL).downloadURL(completion: { url, error in
                guard let url = url, error == nil else {
                    return
                }
                
                let urlString = url.absoluteString
                
                DispatchQueue.main.async {
                    self.label.text = urlString
                    self.imageView.image = image
                }
                
                print("Download URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
            })
        })
        
        // Upload Image Data
        // Get Download URL
        // Save Download ulr to userDefaults
    }
}

