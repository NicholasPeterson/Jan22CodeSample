//
//  SearchViewController.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    let internalView = SearchView()
    var subscriptions = [AnyCancellable]()
    var tableViewDatasource: DataSource?
    let searchManager = SearchManager()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "Search"
        self.edgesForExtendedLayout = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = internalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupSearchField()
    }
    
    func setupTable() {
        internalView.resultsTable.register(SearchResultCell.self, forCellReuseIdentifier:SearchResultCell.reuseIdentifier)
        internalView.resultsTable.delegate = self
        
        tableViewDatasource = DataSource(tableView: internalView.resultsTable) {
            (tableView, indexPath, cocktail) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier,
                                                     for: indexPath) as! SearchResultCell
            cell.populate(with: cocktail)
            return cell
        }
        tableViewDatasource?.defaultRowAnimation = .middle
        
        searchManager.$searchResults
            .sink (receiveValue: { results in
                var snapshot = Snapshot()
                   snapshot.appendSections([.main])
                snapshot.appendItems(results.results)
                self.tableViewDatasource?.apply(snapshot, animatingDifferences: true)
        }).store(in: &subscriptions)
        
    }
    
    func setupSearchField() {
        internalView.searchTextField.textPublisher
            .assign(to: \.currentSearchQuery, on: searchManager)
            .store(in: &subscriptions)
    }
}

extension SearchViewController {
    typealias DataSource = UITableViewDiffableDataSource<Section, Cocktail>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cocktail>
    enum Section: Int, Decodable, Hashable { case main }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedItem = tableViewDatasource?.itemIdentifier(for: indexPath) else { return }
        let detail = UINavigationController(rootViewController: DetailViewController(cocktail: selectedItem))
        present(detail, animated: true) {
            
        }
        
    }
}

class SearchView: UIView {
    let searchTextField = UITextField()
    let resultsTable = UITableView()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .systemBackground
        searchTextField.backgroundColor = .secondarySystemBackground
        searchTextField.layer.cornerRadius = 4
        searchTextField.placeholder = "Search cocktails"
        searchTextField.clearButtonMode = .whileEditing
        
        resultsTable.rowHeight = UITableView.automaticDimension

        safelyAddSubview(searchTextField)
        safelyAddSubview(resultsTable)
        
        searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        resultsTable.topAnchor.constraint(equalTo: searchTextField.bottomAnchor).isActive = true
        resultsTable.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        resultsTable.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        resultsTable.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
