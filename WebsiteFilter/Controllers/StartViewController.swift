//
//  ViewController.swift
//  WebsiteFilter
//
//  Created by Olya Sabadina on 2023-06-05.
//

import UIKit
import WebKit

class StartViewController: UIViewController {
    
    private let inputTextField = UITextField()
    private let backButtoh = UIButton(type: .system)
    private let forwardButton = UIButton(type: .system)
    private let filterButton = UIButton(type: .system)
    private let refreshButtoh = UIButton(type: .system)
    
    private let webView = WKWebView()
    private var stackView = UIStackView()

    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("сработал viewDidLoad")
        configView()
    }
    
    @objc func getValideLinkTextField() {
        guard ValidateManager().isValideLinkMask(text: url) else {return}
        if url.hasPrefix("www.") {
            url.insert(contentsOf: "https://", at: url.startIndex)
        }
        openURL(urlAdress: url)
    }
    
    @objc func openURL(urlAdress: String) {
            guard let url = URL(string: urlAdress) else {return}
            webView.load(URLRequest(url: url))
    }
    
    @objc func backURL() {
        guard webView.canGoBack else {return}
        webView.goBack()
    }
    
    @objc func forwardURL() {
        guard webView.canGoForward else {return}
        webView.goForward()
    }
    
    @objc func filterURL(urlAdress: String) {
            guard let url = URL(string: urlAdress) else {return}
            webView.load(URLRequest(url: url))
    }
    
    @objc func refreshURL() {
        webView.reload()
    }
    
    private func targetActions() {
        inputTextField.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        backButtoh.addTarget(self, action: #selector(backURL), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(forwardURL), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(filterURL), for: .touchUpInside)
        refreshButtoh.addTarget(self, action: #selector(refreshURL), for: .touchUpInside)
        
    }
    
    private func registerOpenURL(textField: UITextField, updatedText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.getValideLinkTextField), object: textField)
        self.perform(#selector(self.getValideLinkTextField), with: textField, afterDelay: 1)
        url = updatedText
    }
    
    private func alertIsNotAllowedURL() {
       let alert = UIAlertController(title: "Attention\nYou input Not Allowed URL.", message: "Please change your URL", preferredStyle: .alert)
       let actionOk = UIAlertAction(title: "OK", style: .cancel)
       alert.addAction(actionOk)
       present(alert, animated: true)
   }

}

//MARK: - TextFieldDelegate:

extension StartViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = inputTextField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        registerOpenURL(textField: textField, updatedText: updatedText)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

//MARK: - WKNavigationDelegate:

extension StartViewController: WKNavigationDelegate {
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("did decidePolicyFor")
       
        let url = navigationAction.request.url?.absoluteString
        if url!.contains("apple") {
            alertIsNotAllowedURL()
// дописать рефреш
            decisionHandler(.cancel)
            print("did decidePolicyFor decisionHandler(.cancel)")
            
        } else {
            decisionHandler(.allow)
        }

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("did Finish")
        
//        backButtoh.isEnabled = webView.canGoBack
//        forwardButton.isEnabled = webView.canGoForward
    }
    
    
    
}

// www.google.com

//MARK: - Set UIConfiguration & constraints:

extension StartViewController {
    
    private func configView() {
        setUpView()
        configInputTextField()
        comfigStackView()
        configBackButtoh()
        configForwardButtoh()
        configFilterButtoh()
        configRefreshButtoh()
        targetActions()
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        title = "Website Filter"
        view.addSubview(webView)
        webView.navigationDelegate = self
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
    
    private func comfigStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView = UIStackView(arrangedSubviews: [backButtoh, forwardButton, refreshButtoh, filterButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        view.addSubview(stackView)
    }
    
    private func configBackButtoh() {
        backButtoh.setImage(UIImage(named: "chevron.backward"), for: .normal)
        backButtoh.setTitleColor(UIColor.systemBlue, for: .normal)
        backButtoh.titleLabel?.font = .boldSystemFont(ofSize: 18)
        backButtoh.buttonSettings(borderWidth: 1, cornerRadius: 15, borderColor: .systemBlue)
        backButtoh.setContentHuggingPriority(UILayoutPriority(200), for: .horizontal)
    }
    
    private func configForwardButtoh() {
        forwardButton.setImage(UIImage(named: "chevron.right"), for: .normal)
        forwardButton.setTitleColor(UIColor.systemBlue, for: .normal)
        forwardButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        forwardButton.buttonSettings(borderWidth: 1, cornerRadius: 15, borderColor: .systemBlue)
    }
    
    private func configRefreshButtoh() {
        refreshButtoh.setImage(UIImage(named: "arrow.clockwise"), for: .normal)
        refreshButtoh.setTitleColor(UIColor.systemBlue, for: .normal)
        refreshButtoh.titleLabel?.font = .boldSystemFont(ofSize: 18)
        refreshButtoh.buttonSettings(borderWidth: 1, cornerRadius: 15, borderColor: .systemBlue)
    }
    
    private func configFilterButtoh() {
        filterButton.setImage(UIImage(named: "line.3.horizontal.decrease.circle"), for: .normal)
        filterButton.setTitleColor(UIColor.systemBlue, for: .normal)
        filterButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        filterButton.buttonSettings(borderWidth: 1, cornerRadius: 15, borderColor: .systemBlue)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
            webView.frame = CGRect(x: 20, y: 150 , width: view.frame.width - 40, height: view.frame.height - 250)
        print("сработал webView.frame")
            stackView.frame = CGRect(x: 20, y: view.frame.height - 100, width: view.frame.width - 40, height: 50)
        print("сработал stackView.frame")
        
        NSLayoutConstraint.activate([
            inputTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            inputTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            inputTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
        print("сработал viewWillLayoutSubviews")
    }
}
