//
//  QuickShareViewController.swift
//  Where was I?
//
//  Created by Andrii Kyrychenko on 15/06/2022.
//

import UIKit
import Photos

class QuickShareViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var assetCollection: PHAssetCollection?
    var photos: PHFetchResult<PHAsset>?
    
    let reuseIdetifier = "tableViewCell"
    var dummyObjects = ["hi", "hello", "fine", "greate"]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let collection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        if collection.firstObject != nil {
            self.assetCollection = collection.firstObject! as PHAssetCollection
            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            self.photos = PHAsset.fetchAssets(in: assetCollection!, options: options)
        } else {
            print("nothing found")
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        if id == "showFullImageSegue" {
            let newVc = segue.destination as! ShowImageViewController
            let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell )
            if let asset = self.photos?[indexPath!.row] {
                newVc.asset = asset
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FotoTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdetifier, for: indexPath) as! FotoTableViewCell
        
        if let asset = self.photos?[indexPath.row] {
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 320, height: 240), contentMode: .aspectFill, options: nil) { result, info in
                if let imade = result {
                    cell.fotoImageView.image = imade
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.photos?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
