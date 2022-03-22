//
//  NetworkService.swift
//  MostPlayedListMVVM
//
//  Created by Furkan Yıldız on 21.03.2022.
//

import Foundation

class Parse {
let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/music/most-played/50/albums.json")!

func requestService(sonucFonk : @escaping(_ response : Model) -> Void) {
//    func requestLogin(completion : @escaping() -> ()) {

    
    let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)

    URLSession.shared.dataTask(with: request) { data, response, error in
        
        if (error != nil) {
            print("Hata var")
        } else {
            
            do {
                let hur = response as! HTTPURLResponse
                
                if (hur.statusCode == 200 && data != nil) {
                   
                    let model = try JSONDecoder().decode(Model.self, from: data!)
//                        self.dataModelRequest = model
//                        completion()
                    

                    DispatchQueue.main.async {
                        sonucFonk(model)

                    }
                }
            }catch {
                
            }
            
        }
        print("servis çağrımı bitti")
        
    }.resume()
    
}

}
