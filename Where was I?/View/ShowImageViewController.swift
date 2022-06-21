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
            shareToFacebook(urlScheme: "facebook-stories://share", appId: "no")
        case 1:
            print("fb_m")
        case 2:
            shareToInstagramStories(urlScheme: "instagram-stories://share")
        case 3:
            print("pin")
        case 4:
            print("tw")
        case 5:
            shareWhatsApp(urlScheme: "whatsapp://app")
        default:
            return
        }
    }

    func shareWhatsApp(urlScheme: String) {
        
        guard let valideUrl = appIsInstall(urlScheme: urlScheme, name: "WhatsApp") else {
            return
        }
        let documentInteractionController :UIDocumentInteractionController?
        guard let imageDate = imageView.image?.pngData() else {
            return
        }
        
        let tempFile = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.wai")
        try? imageDate.write(to: tempFile, options: .atomicWrite)
        documentInteractionController = UIDocumentInteractionController(url: tempFile)
               documentInteractionController?.uti = "net.whatsapp.image"
               documentInteractionController?.presentOpenInMenu(from: .zero, in: view, animated: true)
        
        UIApplication.shared.open(valideUrl, options: [:], completionHandler: nil)
    }
    
    func shareToInstagramStories(urlScheme: String) {
        guard let valideUrl = appIsInstall(urlScheme: urlScheme, name: "Instagram") else {
            return
        }
        guard let imageData: Data = imageView.image?.pngData() else { return }
           let items = [["com.instagram.sharedSticker.backgroundImage": imageData]]
           let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
           UIPasteboard.general.setItems(items, options: pasteboardOptions)
           UIApplication.shared.open(valideUrl, options: [:], completionHandler: nil)
       }
    
    func shareToFacebook(urlScheme: String, appId: String) {
        guard let valideUrl = appIsInstall(urlScheme: urlScheme, name: "Facebook") else {
            return
        }
        guard let imageData: Data = imageView.image?.pngData() else { return }
           let items = [["com.facebook.sharedSticker.backgroundImage": imageData,
                         "com.facebook.sharedSticker.appID": appId]]
           let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
           UIPasteboard.general.setItems(items, options: pasteboardOptions)
           UIApplication.shared.open(valideUrl, options: [:], completionHandler: nil)
       }
    
    func appIsInstall(urlScheme: String, name: String) -> URL? {
        guard
           let corectUrl = URL(string: urlScheme),
           case let application = UIApplication.shared,
            application.canOpenURL(corectUrl)
        else {
            print("Whats need " + name)
            return nil
        }
        return corectUrl
    }
}
