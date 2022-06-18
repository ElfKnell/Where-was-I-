//
//  ShowImageViewController.swift
//  Where was I?
//
//  Created by Andrii Kyrychenko on 17/06/2022.
//

import UIKit
import Photos

class ShowImageViewController: UIViewController {
    
    var asset: PHAsset?
    
    let imageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.frame = CGRect(x: 0.0, y: 200, width: self.view.frame.width, height: self.view.frame.width * 0.5625)
        
        if let myAsset = asset {
            PHImageManager.default().requestImage(for: myAsset, targetSize: CGSize(width: self.view.frame.width, height: self.view.frame.width * 0.5625), contentMode: .aspectFill, options: nil) { result, info in
                if let image = result {
                    self.imageView.image = image
                }
            }
        } else {
            return
        }
        
        view.addSubview(imageView)
    }
    
    @IBAction func shareButtonClicked(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("fb")
        case 1:
            print("fb_m")
        case 2:
            print("insta")
        case 3:
            print("pin")
        case 4:
            print("tw")
        case 5:
            print("wh")
        default:
            return
        }
    }
    
}
