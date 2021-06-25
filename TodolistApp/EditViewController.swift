//
//  EditViewController.swift
//  TodolistApp
//
//  Created by ADMIN on 6/25/21.
//

import UIKit

class EditViewController: UIViewController {
    var transit: Todo? {
        didSet {
            if let transit = transit {
                titleTextfield.text = transit.title
                contentTextview.text = transit.content
                if transit.isCompleted == false {
                    statusButton.setTitle("Undone", for: .normal)
                    statusButton.backgroundColor = .orange
                } else {
                    statusButton.setTitle("Done", for: .normal)
                    statusButton.backgroundColor = .green
                }
            }
        }
    }
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let titleTextfield : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 3
        text.layer.cornerRadius = 10
        text.textAlignment = .center
        text.clipsToBounds = true
        return text
    }()
    
    let contentLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Content"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let contentTextview : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .yellow
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.layer.cornerRadius = 15
        text.clipsToBounds = true
        return text
    }()
    
    let statusLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Status"
        return label
    }()
    
    let statusButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("Undone", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(changeStatus), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit"
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.left"), style: .done, target: self, action: #selector(backtoMain))
        navigationItem.leftBarButtonItem = leftButton
        let rightButton = UIBarButtonItem(title: "SAVE", style: .done, target: self, action: #selector(editData))
        navigationItem.rightBarButtonItem = rightButton
        rightButton.tintColor = .red
        view.backgroundColor = .white
        setupLayout()
    }
    
    @objc func changeStatus() {
        Todo.changeStatusTodoByID(id: transit?.id ?? "")
        if transit?.isCompleted == false {
            statusButton.setTitle("Undone", for: .normal)
            statusButton.backgroundColor = .orange
        } else {
            statusButton.setTitle("Done", for: .normal)
            statusButton.backgroundColor = .green
        }
        
        
        print("\(String(describing: transit?.isCompleted))")
 
    }
    
    @objc func backtoMain() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func editData() {
        Todo.editTodoByID(id: transit?.id ?? "", newTitle: titleTextfield.text ?? "", newContent: contentTextview.text)
        dismiss(animated: true, completion: nil)
    }
    func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(titleTextfield)
        view.addSubview(contentLabel)
        view.addSubview(contentTextview)
        view.addSubview(statusLabel)
        view.addSubview(statusButton)
        
        titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //
        titleTextfield.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0).isActive = true
        titleTextfield.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10).isActive = true
        titleTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        titleTextfield.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //
        contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        contentLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        contentLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //
        contentTextview.topAnchor.constraint(equalTo: contentLabel.topAnchor, constant: 0).isActive = true
        contentTextview.leadingAnchor.constraint(equalTo: titleTextfield.leadingAnchor, constant: 0).isActive = true
        contentTextview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        contentTextview.heightAnchor.constraint(equalToConstant: 500).isActive = true
        //
        statusLabel.topAnchor.constraint(equalTo: contentTextview.bottomAnchor, constant: 50).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor, constant: 0).isActive = true
        statusLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //
        statusButton.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor, constant: 0).isActive = true
        statusButton.centerXAnchor.constraint(equalTo: contentTextview.centerXAnchor, constant: 0).isActive = true
        statusButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        statusButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }

}

