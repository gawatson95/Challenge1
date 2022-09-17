//
//  ViewController.swift
//  Challenge1
//
//  Created by Grant Watson on 9/17/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var list = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearItems))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItem", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Add Item", message: "Add an item to your shopping list.", preferredStyle: .alert)
        ac.addTextField()
        
        let addItem = UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            guard let item = ac.textFields?[0].text?.capitalized else { return }
            self?.list.insert(item, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        ac.addAction(addItem)
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        present(ac, animated: true)
    }
    
    @objc func clearItems() {
        let ac = UIAlertController(title: "Delete all items?", message: "Are you sure you want to delete all items in your list? This can't be undone.", preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.list.removeAll()
            self?.tableView.reloadData()
        }
        
        ac.addAction(confirm)
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        present(ac, animated: true)
    }


}

