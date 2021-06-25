//
//  MainViewController.swift
//  TodolistApp
//
//  Created by ADMIN on 6/24/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var searching : Bool = false
    var datas = [Todo]()
    var filterData = [Todo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        datas = Todo.getAllTodos()
        print("\(datas.count)")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(toAdd))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = "To-do list"
    }
    override func viewDidAppear(_ animated: Bool) {
        datas = Todo.getAllTodos()
        tableView.reloadData()
    }

    @objc func toAdd () {
        let detailVC = AddViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    func convertDatetoString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    @objc func createData(){
        let addVC = AddViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching == false{
         return datas.count
        } else {
          return filterData.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        if searching == false {
        cell.textLabel?.text = datas[indexPath.row].title ?? ""
            cell.detailTextLabel?.text = convertDatetoString(datas[indexPath.row].time ?? Date())
        if datas[indexPath.row].isCompleted == false {
            cell.backgroundColor = .orange
        } else {
            cell.backgroundColor = .green
        }
        return cell
        } else {
            cell.textLabel?.text = filterData[indexPath.row].title ?? ""
            cell.detailTextLabel?.text = convertDatetoString(filterData[indexPath.row].time ?? Date())
            if filterData[indexPath.row].isCompleted == false {
                cell.backgroundColor = .orange
            } else {
                cell.backgroundColor = .green
            }
            return cell
        }
    
       
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (context, view, action) in
            if self.searching == false {
            Todo.deleteTodoByID(id: self.datas[indexPath.row].id!) // xoá trong database
            self.datas.remove(at: indexPath.row) // xoá trong mảng dữ liệu đổ vào tableView
            tableView.reloadData() // reload UI
            }
            else {
                Todo.deleteTodoByID(id: self.filterData[indexPath.row].id!) // xoá trong database
                var k : Int = -1
                for item in self.datas {
                    k+=1
                    if item.id == self.filterData[indexPath.row].id {
                        self.datas.remove(at: k)
                        k-=1
                    }
                }
                self.filterData.remove(at: indexPath.row)
                tableView.reloadData()
                }
        }
            
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editVC = EditViewController()
        let navigation = UINavigationController(rootViewController: editVC)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true, completion: nil)
        if searching == false {
        editVC.transit = datas[indexPath.row]
        } else {
            editVC.transit = filterData[indexPath.row]
        }
    }
}
extension MainViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty { searching = false
        } else {
            searching = true
            filterData = Todo.searchItem(searchText) }
            tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
