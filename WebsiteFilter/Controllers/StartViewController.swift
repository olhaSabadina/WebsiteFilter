//
//  ViewController.swift
//  WebsiteFilter
//
//  Created by Olya Sabadina on 2023-06-05.
//

import UIKit
import WebKit

class StartViewController: UIViewController {
    
    
    let inputTextField = UITextField()
    let webView = WKWebView()
    let backButtoh = UIButton(type: .system)
    let forwardButton = UIButton(type: .system)
    let filterButton = UIButton(type: .system)
    var menuStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        
        guard let url = URL(string: "https://google.com") else {return}
        webView.load(URLRequest(url: url))
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
            webView.frame = CGRect(x: 20, y: 150 , width: view.frame.width - 40, height: view.frame.height - 300)
            menuStackView.frame = CGRect(x: 20, y: view.frame.height - 100, width: view.frame.width - 40, height: 50)
        
        NSLayoutConstraint.activate([
            inputTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            inputTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            inputTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }
}

//MARK: - TextFieldDelegate:

extension StartViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    
}


//MARK: - Set UIConfiguration & constraints:

extension StartViewController {
    
    private func configView() {
        setUpView()
        configInputTextField()
        comfigMenuStackView()
        configBackButtoh()
        configForwardButtoh()
        configFilterButtoh()
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        title = "Website Filter"
        view.addSubview(webView)
    }
    private func configInputTextField() {
        inputTextField.delegate = self
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.placeholder = " www.example.com"
        inputTextField.clearButtonMode = .always
        inputTextField.font = .systemFont(ofSize: 25)
        inputTextField.layer.borderWidth = 1
        inputTextField.layer.borderColor = UIColor.lightGray.cgColor
        inputTextField.layer.cornerRadius = 8
        inputTextField.autocapitalizationType = .none
        view.addSubview(inputTextField)
    }
    
    private func comfigMenuStackView() {
        menuStackView.translatesAutoresizingMaskIntoConstraints = false
        menuStackView = UIStackView(arrangedSubviews: [backButtoh, forwardButton, filterButton])
        menuStackView.axis = .horizontal
        menuStackView.distribution = .fill
        view.addSubview(menuStackView)
    }
    
    private func configBackButtoh() {
        backButtoh.translatesAutoresizingMaskIntoConstraints = false
        backButtoh.widthAnchor.constraint(equalTo: menuStackView.widthAnchor, multiplier: 1/3).isActive = true
        backButtoh.setTitle("Back", for: .normal)
        backButtoh.setTitleColor(UIColor.systemBlue, for: .normal)
        backButtoh.titleLabel?.font = .boldSystemFont(ofSize: 18)
        backButtoh.buttonSettings(borderWidth: 1, cornerRadius: 15, borderColor: .systemBlue)
    }
    
    private func configForwardButtoh() {
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.widthAnchor.constraint(equalTo: menuStackView.widthAnchor, multiplier: 1/3).isActive = true
        forwardButton.setTitle("Forward", for: .normal)
        forwardButton.setTitleColor(UIColor.systemBlue, for: .normal)
        forwardButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        forwardButton.buttonSettings(borderWidth: 1, cornerRadius: 15, borderColor: .systemBlue)
    }
    
    private func configFilterButtoh() {
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.widthAnchor.constraint(equalTo: menuStackView.widthAnchor, multiplier: 1/3).isActive = true
        filterButton.setTitle("Filter", for: .normal)
        filterButton.setTitleColor(UIColor.systemBlue, for: .normal)
        filterButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        filterButton.buttonSettings(borderWidth: 1, cornerRadius: 15, borderColor: .systemBlue)
    }
}
