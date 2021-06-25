//
//  AddViewController.swift
//  TodolistApp
//
//  Created by ADMIN on 6/24/21.
//

import UIKit

class AddViewController: UIViewController {

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
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add"
        let rightButton = UIBarButtonItem(title: "SAVE", style: .done, target: self, action: #selector(saveData))
        navigationItem.rightBarButtonItem = rightButton
        rightButton.tintColor = .red
        view.backgroundColor = .white
        setupLayout()
    }
    

    @objc func saveData() {
        Todo.addNewTodo(title: titleTextfield.text ?? "", content: contentTextview.text, isComplete: false, time: Date(timeIntervalSinceNow: 25600))
        navigationController?.popViewController(animated: true)
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
