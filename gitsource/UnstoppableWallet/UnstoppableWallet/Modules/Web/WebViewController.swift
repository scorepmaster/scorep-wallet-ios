//
//  webViewController.swift
//  BankWallet
//
//  Created by iMac on 5/15/20.
//  Copyright © 2020 Grouvi. All rights reserved.
//

import UIKit
import WebKit
import ThemeKit
class WebViewController: ThemeViewController, UIScrollViewDelegate {
    
   
    
let webview = WKWebView(frame: CGRect.zero)
    init() {
        super.init()
        self.tabBarItem = UITabBarItem(title: "Rewards".localized, image: UIImage(named: "switch_wallet_24"), tag: 0)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rewards"
       // navigationController?.navigationBar.prefersLargeTitles = true
     
        
        webview.frame  = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        //webview.load(URLRequest(url: Bundle.main.url(forResource: "index", withExtension:"html", subdirectory: "subdirectories")! as URL) as URLRequest)
        self.view.addSubview(webview)
        webview.navigationDelegate = self
        webview.scrollView.bounces = false
        webview.scrollView.showsHorizontalScrollIndicator = false
        webview.scrollView.showsVerticalScrollIndicator = false
        webview.scrollView.bouncesZoom = false
        
        //webview.scrollView.isHidden = true
        //webview.scrollView.isScrollEnabled = false
        // Do any additional setup after loading the view.
        loadUrl()
    }
    
   
    //MARK: - UIScrollViewDelegate

    
    
     func webViewDidFinishLoad(_ webView: WKWebView) {
        self.webview.scrollView.showsHorizontalScrollIndicator = false
        self.webview.scrollView.showsVerticalScrollIndicator = false
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.x > 0){
            scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y)
        }
     }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        .themeDefault
    }
    
    func loadUrl(){
          
              if let url = URL(string: "https://eprotoken.app/login"){
                  let request = URLRequest(url: url)
                  //self.startAnimating()
                  webview.load(request)
                  
          }
          
      }
    

}
//MARK:- WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
       scrollView.pinchGestureRecognizer?.isEnabled = false
    }
    
    func viewForZooming(in: UIScrollView) -> UIView? {
              return nil
          }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      //  stopLoader()
       
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
   //  self.startActivityWithMessage(msg: "")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //self.stopAnimating()
     //   stopLoader()
    }
    
}
