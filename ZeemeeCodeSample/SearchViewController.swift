//
//  SearchViewController.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    private let internalView = SearchView()
    private var subscriptions = [AnyCancellable]()
    private var tableViewDatasource: DataSource?
    private let searchManager = SearchManager()
    
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
    
    private func setupTable() {
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
    
    private func setupSearchField() {
        internalView.searchTextField.textPublisher
            .assign(to: \.currentSearchQuery, on: searchManager)
            .store(in: &subscriptions)
    }
    
    private func presentDetailForId(id: String) {
        CocktailService().detailPublisher(for: id)
            .receive(on: DispatchQueue.main)
            .sink { result in
                if case Subscribers.Completion.failure(let error) = result {
                    print(error)
                }
            } receiveValue: { cocktail in
                let detail = UINavigationController(rootViewController: DetailViewController(cocktail: cocktail))
                self.present(detail, animated: true) {
                }
            }.store(in: &subscriptions)
    }
}

extension SearchViewController {
    typealias DataSource = UITableViewDiffableDataSource<Section, LiteCocktail>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, LiteCocktail>
    enum Section: Int, Decodable, Hashable { case main }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedItem = tableViewDatasource?.itemIdentifier(for: indexPath) else { return }
        
        presentDetailForId(id: selectedItem.idDrink)
        tableView.cellForRow(at: indexPath)?.isSelected = false
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
        searchTextField.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
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
