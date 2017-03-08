//
//  UploadingPhotosViewController.swift
//  Instagram
//
//  Created by Arthur on 2017/3/6.
//  Copyright © 2017年 Kuan-Ting Wu (Arthur Wu). All rights reserved.
//

import UIKit

class UploadingPhotosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var captionField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
               // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        
        tapGestureRecognizer.addTarget(self, action: #selector(imageTapped(_:)))
        
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(_ sender: UITapGestureRecognizer)
    {
        print("tapped")
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        imageView.image = editedImage
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    @IBAction func submittingPost(_ sender: Any)
    {
        if captionField.text != ""
        {
            Post.postUserImage(image: imageView.image, withCaption: captionField.text, withCompletion:
                { (success: Bool, error: Error?) in
                    if success
                    {
                        print ("success")
                        self.tabBarController?.selectedIndex = 0
                    
                    }
                    else
                    {
                        print(error?.localizedDescription)
                    }
                }
            )
        }
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
