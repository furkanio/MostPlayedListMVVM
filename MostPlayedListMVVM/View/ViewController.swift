//
//  ViewController.swift
//  MostPlayedListMVVM
//
//  Created by Furkan Yıldız on 21.03.2022.
//

import UIKit

class ViewController: UIViewController {

    var request = Parse()

    var viewModel = ListViewModel()
    var orginalGetData  : Model?
    var updatedData : Model?
    
    var searchController = UISearchController()
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

   

    
    @IBOutlet var cvList: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cvList.register(UINib(nibName: "Album_CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Album_CollectionViewCell")

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
//        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.isHidden = false
        
        getDataFromViewModel()
        
//        getDatas()
    }
    
    func filterCurrentData(searchTerm: String) {
        
        if searchTerm.count > 0 {
            updatedData = orginalGetData
            
            let filteredResults = updatedData?.feed.results.filter { $0.name.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())
                
            }
            
            updatedData?.feed.results = filteredResults!
            cvList.reloadData()
            
                
            }
        }
    
    func restoreCurrentData() {
        updatedData = orginalGetData
        cvList.reloadData()
    }
            
            
    
    
 
    
    override func viewWillLayoutSubviews() {
        
        viewFunc()
        
    }
    
    
    func viewFunc() {
        let layout = cvList.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        
        layout.minimumInteritemSpacing = 1


        if self.view.frame.size.width < self.view.frame.size.height {
             // Portrait
                    let spacing = self.view.frame.size.width - 20
                    let width = spacing / 2
                    let height = width
            layout.itemSize = CGSize(width: width, height: height)
        }
        else {
             // Landscape
                    let spacing = self.view.frame.size.width - 5
                    let width = spacing / 5
                    let height = width * 2/3
            layout.itemSize = CGSize(width: width, height: height)
        }
    }
    
//    func getDatas() {
//        viewModel.getDataFromService()
//        self.albumData1 = viewModel.albumData
//        cvList.reloadData()
//    }
    
    func getDataFromViewModel() {
        request.requestService(sonucFonk: getAllData)

    }
    
    
    

    func getAllData(resp : Model) {

        self.orginalGetData = resp
        DispatchQueue.main.async {
            
            self.cvList.reloadData()

        }
    }
    
    

}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering {
            return updatedData?.feed.results.count ?? 0
        }
            return orginalGetData?.feed.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var c = orginalGetData?.feed.results[indexPath.row]

        if isFiltering {
             c = updatedData?.feed.results[indexPath.row]
        } else {
             c = orginalGetData?.feed.results[indexPath.row]

        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Album_CollectionViewCell", for: indexPath) as! Album_CollectionViewCell
        
        cell.bindData(photo: c!)
                
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "sgDetail", sender: indexPath.row)
        searchController.isActive = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sgDetail" {
            let photoDetail = segue.destination as! VC_Detail
            
            if isFiltering {
                
                photoDetail.getModel = updatedData?.feed.results[sender as! Int]

                
            } else {
                photoDetail.getModel = orginalGetData?.feed.results[sender as! Int]

            }
            
        }
    }
    
    
    
    
}

extension ViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            filterCurrentData(searchTerm: searchText)
            print(searchText)

        }
        
    }
}

extension ViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.isActive = false
        
        if let searchText = searchBar.text {
            filterCurrentData(searchTerm: searchText)
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.isActive = false
        
        if isFiltering {
            
//            getDataFromViewModel()
            restoreCurrentData()
        } else {
            restoreCurrentData()

        }
        
        
        
    }
    
    
}
