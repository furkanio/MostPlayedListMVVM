//
//  TableViewController.swift
//  MostPlayedListMVVM
//
//  Created by Furkan Yıldız on 22.03.2022.
//

import UIKit

class TableViewController: UIViewController {

    var request = Parse()

    var viewModel = ListViewModel()
    
    var orginalGetData  : Model?
    var updatedData : Model?
    
    var searchController = UISearchController()
    private let refreshControl = UIRefreshControl()

    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

   
    @IBOutlet var tvList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tvList.register(UITableViewCell.self, forCellReuseIdentifier: "Album_TableViewController")
        searchController.searchBar.placeholder = "Search Album"
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        searchController.searchBar.isHidden = false
        
        getDataFromViewModel()
        
//        getDatas()
        
        let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)

            // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
            tvList.refreshControl = refreshControl
        }

    @objc func doSomething(refreshControl: UIRefreshControl) {
            print("Hello World!")

            // somewhere in your code you might need to call:

//            tvList.reloadData()
            refreshControl.endRefreshing()
            getDataFromViewModel()

        }
    
    func filterCurrentData(searchTerm: String) {
        
        if searchTerm.count > 0 {
            updatedData = orginalGetData
            
            let filteredResults = updatedData?.feed.results.filter { $0.name.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())
                
            }
            
            updatedData?.feed.results = filteredResults!
            tvList.reloadData()
            
            
                
        } else  {
            
            restoreCurrentData()
        }
        
    
        }
    
    func restoreCurrentData() {
        updatedData = orginalGetData
        tvList.reloadData()
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
            
            self.tvList.reloadData()

        }
    }
    
    

}

extension TableViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return updatedData?.feed.results.count ?? 0
        }
            return orginalGetData?.feed.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var c = orginalGetData?.feed.results[indexPath.row]

        if isFiltering {
             c = updatedData?.feed.results[indexPath.row]
        } else {
             c = orginalGetData?.feed.results[indexPath.row]

        }
        
        let cell = Bundle.main.loadNibNamed("Album_TableViewCell", owner: self, options: nil)?.first as! Album_TableViewCell
 
        
        cell.bindData(photo: c!)
                
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailAlbumFromTableView", sender: indexPath.row)
        searchController.isActive = false
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailAlbumFromTableView" {
            let photoDetail = segue.destination as! VC_Detail
            
            
            
            if isFiltering {
                
                photoDetail.getModel = updatedData?.feed.results[sender as! Int]

                
            } else {
                photoDetail.getModel = orginalGetData?.feed.results[sender as! Int]

            }
            
        }
    }
    
    
    
    
}

extension TableViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            filterCurrentData(searchTerm: searchText)
            print(searchText)

        }
        
    }
}

extension TableViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.isActive = false
        
        if let searchText = searchBar.text {
            filterCurrentData(searchTerm: searchText)
            
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.isActive = false
        
        if isFiltering {
            restoreCurrentData()
        }
        
        
        
    }
    
    
}
