//
//  Album_CollectionViewCell.swift
//  MostPlayedListMVVM
//
//  Created by Furkan Yıldız on 21.03.2022.
//

import UIKit

class Album_CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lbl_Album_Name: UILabel!
    @IBOutlet var iv_Album: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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


