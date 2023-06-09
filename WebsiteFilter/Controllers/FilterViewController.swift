//
//  FilterViewController.swift
//  WebsiteFilter
//
//  Created by Olya Sabadina on 2023-06-08.
//

import UIKit

class FilterViewController: UIViewController {
    
    private let filterTable = UITableView()
    
    var filterWords: [String] = [] {
        didSet {
            filterTable.reloadData()
        }
    }
    
    var completion: ((String?)->Void)?
    
    
//MARK: - Life cycle:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setFilterTable()
        setBarButtonAddWords()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
//MARK: - @objc func:
    @objc func addWordAlert() {
        let alert = UIAlertController(title: "Exception", message: "Add a word to prevent opening links", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default){ _ in
            guard let word = alert.textFields?.first?.text, !word.isEmpty else {return}
            self.filterWords.append(word)
        }
        let actionCancel = UIAlertAction(title: "Cansel", style: .cancel)
        alert.addTextField { textField in
            textField.placeholder = "input exception world"
            textField.font = .systemFont(ofSize: 17)
        }
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
    
//MARK: - Private func:
    private func setUpView() {
        view.backgroundColor = .white
        title = "Filter words"
    }
    
    private func setFilterTable() {
        filterTable.frame = view.bounds
        filterTable.delegate = self
        filterTable.dataSource = self
        filterTable.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.cellId)
        view.addSubview(filterTable)
    }
    
    private func setBarButtonAddWords() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWordAlert))
        navigationController?.navigationItem.rightBarButtonItem = addButton
    }
    
}

//MARK: - Table Delegate, DataSource:

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.cellId, for: indexPath) as? FilterTableViewCell else {return UITableViewCell()}
        cell.filterLabel.text = filterWords[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            filterWords.remove(at: indexPath.row)
        }
    }
}
