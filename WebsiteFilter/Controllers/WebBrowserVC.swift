//
//  ViewController.swift
//  WebsiteFilter
//
//  Created by Olya Sabadina on 2023-06-05.
//

import UIKit
import WebKit

class WebBrowserVC: UIViewController {
    
    private var url = ""
    private var exceptionArray: [String] = ["xxx"]
    
    private let webView = WKWebView()
    private let validManager = ValidateManager()
    private let inputTextField = UITextField()
    private let backButton = UIButton(type: .system)
    private let forwardButton = UIButton(type: .system)
    private let filterButton = UIButton(type: .system)
    private let refreshButton = UIButton(type: .system)
    private let сlearButton = UIButton(type: .system)
    private var stackView = UIStackView()
    
    //MARK: - Life cycle:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    //MARK: - @objc func:
    
    @objc private func inputUrl() {
        guard let textTF = inputTextField.text else {return}
        url = textTF
    }
    
    @objc private func getValideLinkTextField() {
        guard validManager.isValideLinkMask(text: url) else {
            openURL(urlAdress: "https://www.google.com/search?q=\(url)")
            return
        }
        if url.hasPrefix("www.") {
            url.insert(contentsOf: "https://", at: url.startIndex)
        }
        openURL(urlAdress: url)
    }
    
    @objc private func openURL(urlAdress: String) {
        DispatchQueue.main.async {
            guard let url = URL(string: urlAdress) else {return}
            self.webView.load(URLRequest(url: url))
        }
    }
    
    @objc private func openFilterListVC() {
        let filterVC = FilterViewController()
        let navController = UINavigationController(rootViewController: filterVC)
        filterVC.filterWords = exceptionArray
        filterVC.completion = { [weak self] wordsException in
            self?.exceptionArray = wordsException
        }
        if let presentationController = navController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
        }
        navigationController?.present(navController, animated: true)
    }
    
    //MARK: - WebViewActions:
    
    @objc private func backURL() {
        guard webView.canGoBack else {return}
        webView.goBack()
    }
    
    @objc private func forwardURL() {
        guard webView.canGoForward else {return}
        webView.goForward()
    }
    
    @objc private func refreshURL() {
        webView.reload()
    }
    
    @objc private func webClearTextField() {
        webView.stopLoading()
        inputTextField.text = ""
    }
    
    //MARK: - private Functions
    
    private func setTargetButton() {
        inputTextField.addTarget(self, action: #selector(inputUrl), for: .editingChanged)
        backButton.addTarget(self, action: #selector(backURL), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(forwardURL), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(openFilterListVC), for: .touchUpInside)
        refreshButton.addTarget(self, action: #selector(refreshURL), for: .touchUpInside)
        сlearButton.addTarget(self, action: #selector(webClearTextField), for: .touchUpInside)
    }
    
    private func alertIsNotAllowedURL() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: ElementsTitles.AlertTitleAndMessage.notAllowedURTitle, message: ElementsTitles.AlertTitleAndMessage.notAllowedURMessage, preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(actionOk)
            self.present(alert, animated: true)
        }
    }
}

//MARK: - TextFieldDelegate:

extension WebBrowserVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        getValideLinkTextField()
        return true
    }
}

//MARK: - WKNavigationDelegate:

extension WebBrowserVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url?.absoluteString else {return}
        if exceptionArray.contains(where: {url.contains($0)}) {
            self.alertIsNotAllowedURL()
            openURL(urlAdress: ElementsTitles.ActionPolicy.defaultURL)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}

//MARK: - Set UIConfiguration & constraints:

extension WebBrowserVC {
    
    private func configView() {
        setUpView()
        configInputTextField()
        setLeftImageOnTextField()
        setRightButtonOnTextField()
        comfigStackView()
        setStackButtons()
        setWebView()
        setTargetButton()
        setClearStopButton()
        setConstraints()
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        title = ElementsTitles.TitleViewControllers.webBrowserVC
    }
    
    private func setWebView() {
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
    }
    
    private func configInputTextField() {
        view.addSubview(inputTextField)
        inputTextField.delegate = self
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.placeholder = " search "
        inputTextField.font = .systemFont(ofSize: 18)
        inputTextField.autocapitalizationType = .none
        inputTextField.autocorrectionType = .no
        inputTextField.borderColorRadius(borderWidth: 1, cornerRadius: 17, borderColor: .lightGray)
    }
    
    private func setLeftImageOnTextField() {
        let leftIViewGoogle = UIImageView(frame: CGRect(x: 10, y: 8, width: 20, height: 20))
        leftIViewGoogle.image = ElementsTitles.ImageForButtons.googleImage
        leftIViewGoogle.contentMode = .scaleAspectFit
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
        leftView.addSubview(leftIViewGoogle)
        inputTextField.leftViewMode = UITextField.ViewMode.always
        inputTextField.leftView = leftView
    }
    
    private func setRightButtonOnTextField() {
        let rightButton = UIButton()
        rightButton.setImage(ElementsTitles.ImageForButtons.magnifyingglassImage, for: .normal)
        rightButton.frame = CGRect(x: 0, y: 8, width: 20, height: 20)
        rightButton.addTarget(self, action: #selector(getValideLinkTextField), for: .touchUpInside)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 34))
        rightView.addSubview(rightButton)
        inputTextField.rightViewMode = UITextField.ViewMode.always
        inputTextField.rightView = rightView
    }
    
    private func comfigStackView() {
        stackView = UIStackView(arrangedSubviews: [backButton, forwardButton, refreshButton, filterButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 22
        view.addSubview(stackView)
    }
    
    private func setStackButtons() {
        let arrayButtons = [backButton, forwardButton, refreshButton, filterButton]
        arrayButtons.forEach { button in
            button.setTitleColor(UIColor.systemBlue, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 18)
            button.borderColorRadius(borderWidth: 1, cornerRadius: 17, borderColor: .systemBlue)
        }
        backButton.setImage(ElementsTitles.ImageForButtons.backImage, for: .normal)
        forwardButton.setImage(ElementsTitles.ImageForButtons.forwardImage, for: .normal)
        refreshButton.setImage(ElementsTitles.ImageForButtons.refreshImage, for: .normal)
        filterButton.setImage(ElementsTitles.ImageForButtons.filterImage, for: .normal)
    }
    
    private func setClearStopButton() {
        view.addSubview(сlearButton)
        сlearButton.translatesAutoresizingMaskIntoConstraints = false
        сlearButton.setImage(ElementsTitles.ImageForButtons.сlearImage, for: .normal)
        сlearButton.tintColor = .red
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            inputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputTextField.trailingAnchor.constraint(equalTo: сlearButton.leadingAnchor, constant: -10),
            inputTextField.topAnchor.constraint(equalTo: navigationItem.titleView?.bottomAnchor ?? view.safeAreaLayoutGuide.topAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 34),
            
            сlearButton.centerYAnchor.constraint(equalTo: inputTextField.centerYAnchor),
            сlearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            сlearButton.heightAnchor.constraint(equalTo: сlearButton.widthAnchor),
            сlearButton.widthAnchor.constraint(equalToConstant: 25),
            
            webView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: inputTextField.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: сlearButton.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -10),
            
            stackView.leadingAnchor.constraint(equalTo: inputTextField.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: сlearButton.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}
