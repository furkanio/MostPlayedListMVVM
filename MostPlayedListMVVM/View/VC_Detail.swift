//
//  VC_Detail.swift
//  MostPlayedListMVVM
//
//  Created by Furkan Yıldız on 22.03.2022.
//

import UIKit

class VC_Detail: UIViewController {
    
    @IBOutlet var iv_Album_Detail: UIImageView!
    @IBOutlet var lbl_AlbumName_Detail: UILabel!
    @IBOutlet var lbl_AlbumGenres_Detail: UILabel!
    @IBOutlet var lbl_AlbumDate_Detail: UILabel!
    @IBOutlet var lbl_AlbumArtistName_Detail: UILabel!
    
    
    var getModel : Result?

    override func viewDidLoad() {
        super.viewDidLoad()

        lbl_AlbumGenres_Detail.text = getModel?.genres[0].name
        lbl_AlbumName_Detail.text = getModel?.name
        lbl_AlbumDate_Detail.text = getModel?.releaseDate
        lbl_AlbumArtistName_Detail.text = getModel?.artistName
        
        if getModel!.artworkUrl100 != "" {
            let resimUrlStr = getModel!.artworkUrl100
            let url = URL(string: resimUrlStr)!
            let data = try? Data(contentsOf: url)
            iv_Album_Detail.image = UIImage(data: data!)
        }
        
        // Do any additional setup after loading the view.
    }
    
    



}
