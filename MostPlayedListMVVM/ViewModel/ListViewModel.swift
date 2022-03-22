//
//  ListViewModel.swift
//  MostPlayedListMVVM
//
//  Created by Furkan Yıldız on 21.03.2022.
//

import Foundation

class ListViewModel {
    

    
    var request = Parse()
    var albumData : Model?

    
    func getDataFromService() {
        
        request.requestService(sonucFonk: getAllData)
        
    }
    
    func getAllData(resp : Model) {
        self.albumData = resp
    }
    
    
}
