//
//  KCWebViewController.swift
//  fourGame
//
//  Created by Kevin on 2017/7/3.
//  Copyright © 2017年 rmbp840. All rights reserved.
//

import UIKit
import SnapKit

class KCWebViewController: UIViewController  {
    
    fileprivate let urlStr = "https://a38278.com"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
        addConstraints()
       
        myWebView.loadRequest(URLRequest(url: URL(string: urlStr)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
//            progressBar.progress = self.myWebView.
        }
    }
    
   
//    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        if keyPath == "title" {//如果加载完成，keypath值为标题时，设置界面的标题
//            self.title = self.webView!.title
//        } else if keyPath == "estimatedProgress" {//如果为添加的观察者，设置进度条的加载进度 estimatedProgress是苹果提供给开发者的网页加载的进度
//            self.progressBar!.progress = Float(self.webView!.estimatedProgress)
//        }
//
//
//    }
    
  
    // 屏幕旋转
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            // 横屏
            myWebView.snp.updateConstraints({ (make) in
                make.top.equalToSuperview()
            })
            bottomToolBar.snp.updateConstraints({ (make) in
                make.height.equalTo(0.1)
            })
        }
        else if UIDevice.current.orientation.isPortrait {
            // 竖屏
            myWebView.snp.updateConstraints({ (make) in
                make.top.equalToSuperview().offset(0)
            })
            bottomToolBar.snp.updateConstraints({ (make) in
                make.height.equalTo(50)
            })
        }
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
    fileprivate lazy var myWebView: UIWebView = {
        // WKWebView自适应网页大小
        //                let jsStr = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        //                let userScript = WKUserScript(source: jsStr, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        //                let wkUController = WKUserContentController()
        //                wkUController.addUserScript(userScript)
        //                let wkWebConfig = WKWebViewConfiguration()
        //                wkWebConfig.userContentController = wkUController
        //                let webView = WKWebView(frame: .zero, configuration: wkWebConfig)
        
        // WKWebView自适应网页大小 方式2
        //        var scriptContent = "var meta = document.createElement('meta');"
        //        scriptContent += "meta.name='viewport';"
        //        scriptContent += "meta.content='width=device-width';"
        //        scriptContent += "document.getElementsByTagName('head')[0].appendChild(meta);"
        //        webView.evaluateJavaScript(scriptContent, completionHandler: nil)
        
        let webView = UIWebView()
        webView.scalesPageToFit = true
//        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)//添加观察者

        return webView
    }()
    
    
    fileprivate lazy var progressBar: UIProgressView = {

        let progress = UIProgressView();
        
        return progress
    }()
    fileprivate let bottomToolBar = KCToolBar()
}




// MARK: - Event Response
extension KCWebViewController {
    @objc fileprivate func bottomToolBarHomeBtnAction() {
        myWebView.loadRequest(URLRequest(url: URL(string: urlStr)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20))
    }
    
    @objc fileprivate func bottomToolBarBackBtnAction() {
        if myWebView.canGoBack {
            myWebView.goBack()
        }
    }
    
    @objc fileprivate func bottomToolBarNextBtnAction() {
        myWebView.goForward()
    }
    
    @objc fileprivate func bottomToolBarRefreshBtnAction() {
        myWebView.reload()
    }
    
    @objc fileprivate func bottomToolBarExitBtnAction() {
        let alertVC = UIAlertController(title: nil, message: "是否退出？", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "取消", style: .default)
        let actionConfirm = UIAlertAction(title: "确定", style: .destructive) { (alert) in
            abort()
        }
        alertVC.addAction(actionCancel)
        alertVC.addAction(actionConfirm)
        present(alertVC, animated: true)
    }
}



// MARK: - 私有方法
extension KCWebViewController {
    fileprivate func setupUI() {
        bottomToolBar.backgroundColor = .white
        view.backgroundColor = .white
        view.addSubview(myWebView)
        view.addSubview(bottomToolBar)
        view.addSubview(progressBar);
        progressBar.frame = CGRect(x: 0, y: 0, width: 100, height: 2);
        
        bottomToolBar.homeBtn.addTarget(self, action: #selector(KCWebViewController.bottomToolBarHomeBtnAction), for: .touchUpInside)
        bottomToolBar.backBtn.addTarget(self, action: #selector(KCWebViewController.bottomToolBarBackBtnAction), for: .touchUpInside)
        bottomToolBar.nextBtn.addTarget(self, action: #selector(KCWebViewController.bottomToolBarNextBtnAction), for: .touchUpInside)
        bottomToolBar.refreshBtn.addTarget(self, action: #selector(KCWebViewController.bottomToolBarRefreshBtnAction), for: .touchUpInside)
        bottomToolBar.exitBtn.addTarget(self, action: #selector(KCWebViewController.bottomToolBarExitBtnAction), for: .touchUpInside)
        
        
    }
    
    

    
    fileprivate func addConstraints() {
        bottomToolBar.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.bottom.right.equalToSuperview()
        }
        myWebView.snp.makeConstraints { [unowned self] (make) in
            make.top.equalToSuperview().offset(20)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(self.bottomToolBar.snp.top)
        }
    }
}

