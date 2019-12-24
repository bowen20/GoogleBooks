//
//  HomeViewController.swift
//  GoogleBooks
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var homeTableView: UITableView!
    
 let viewModel = ViewModel()
        let searchController = UISearchController(searchResultsController: nil)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupHome()
            searchSetup()
        }
        
        private func setupHome() {
            homeTableView.register(UINib(nibName: BookTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: BookTableCell.identifier)
            
            homeTableView.tableFooterView = UIView(frame: .zero) //remove empty cells
            
            homeTableView.separatorStyle = .none //remove the dividing lines
                        
            viewModel.delegate = self
        }
        
        private func searchSetup() {
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.delegate = self
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
        }
        
    }

    //MARK: Home - TableView
    extension HomeViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.books.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: BookTableCell.identifier, for: indexPath) as! BookTableCell
            let book = viewModel.books[indexPath.row]
            cell.book = book
            return cell
        }
        
    }

    extension HomeViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 160
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let book = viewModel.books[indexPath.row]
            viewModel.currentBook = book //set current album on VM
            let bookVC = storyboard?.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
            bookVC.viewModel = viewModel //pass view model to AlbumVC
            bookVC.hidesBottomBarWhenPushed = true
            navigationController?.view.backgroundColor = .white
            navigationController?.pushViewController(bookVC, animated: true)
        }
    }

    //MARK: ViewModel Delegate
    extension HomeViewController: ViewModelDelegate {
        
        func update() {
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
            }
        }
    }

    //MARK: Search Delegate
    extension HomeViewController: UISearchBarDelegate {
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let search = searchBar.text,
                let sanitized = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
       
            viewModel.get(sanitized)
        }
    }
