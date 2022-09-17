//
//  ViewController.swift
//  NewsApp
//
//  Created by Berkay on 15.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // First screen gif settings
        let gif = UIImage.gifImageWithName("brain")
        imageView.image = gif
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.backgroundView.isHidden = true
            let story = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
            story.modalPresentationStyle = .fullScreen
            story.modalTransitionStyle = .crossDissolve
            self.show(story, sender: nil)
        }
        
    }


}

