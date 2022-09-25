//
//  ViewController.swift
//  TicketMasterAssessment
//
//  Created by Anil Persaud on 9/23/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var eventViewModel = EventViewModel()
    var searchedEvents = [EventModel]()
    var eventsList: [EventModel]?
    
    var isSearching = false
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCells.eventCollectionCellIdentifier)
        return cv
    }()
    
    private var searchBar: UISearchBar = {
        let search = UISearchBar()
        let searchTextField = search.searchTextField
        searchTextField.textColor = UIColor.black
        searchTextField.clearButtonMode = .always
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LA Events"
        initialSetUp()
        eventViewModel.getEventsList()
    }
    
    private func initialSetUp() {
        setUpUI()
        setUpDelegates()
        setUpConstraints()
    }
    
    private func setUpUI() {
        view.addSubview(collectionView)
        view.addSubview(searchBar)
    }
    
    private func setUpDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        eventViewModel.delegate = self
    }
    
    private func setUpConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        // Layout constraints for `searchBar`
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        // Layout constraints for `collectionView`
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension ViewController: EventsViewModelDelegate {
    func didReceiveEventsResponse(_ eventsResponse: EventsResponseModel) {
        if (eventsResponse.errorMessage != nil) {
        } else {
            eventsList = eventsResponse.data?._embedded.events
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? searchedEvents.count : eventsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.eventCollectionCellIdentifier, for: indexPath) as! EventCollectionViewCell
        let eventModel = isSearching ? searchedEvents[indexPath.row] : eventsList![indexPath.row]
        eventCell.eventModel = eventModel
        return eventCell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 3.0
        static let itemHeight: CGFloat = 245
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemWidth(for: view.frame.width, spacing: 0)
        
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2
        
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return finalWidth - 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedEvents = eventsList!.filter { $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() }
        isSearching = true
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        collectionView.reloadData()
    }
}


