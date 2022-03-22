//
//  Album_TableViewCell.swift
//  MostPlayedListMVVM
//
//  Created by Furkan Yıldız on 22.03.2022.
//

import UIKit

class Album_TableViewCell: UITableViewCell {
    
    @IBOutlet var iv_Album: UIImageView!
    @IBOutlet var lbl_Album_Name: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(photo: Result) {
        
        if photo.artworkUrl100 != "" {
            let resimUrlStr = photo.artworkUrl100
            let url = URL(string: resimUrlStr)!
            let data = try? Data(contentsOf: url)
            iv_Album.image = UIImage(data: data!)
            lbl_Album_Name.text = photo.name
            iv_Album.contentMode = UIView.ContentMode.scaleToFill
        }
        
        
    }
    
    
    
}
