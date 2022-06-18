//
//  FotoTableViewCell.swift
//  Where was I?
//
//  Created by Andrii Kyrychenko on 17/06/2022.
//

import UIKit

class FotoTableViewCell: UITableViewCell {
    
    static let indetifier = "FotoTableViewCell"
    
    @IBOutlet weak var fotoImageView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
