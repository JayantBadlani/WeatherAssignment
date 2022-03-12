//
//  LoadingViewController.swift


import UIKit

/*
 Usage :
 let loadingViewController = LoadingViewController()
 add(loadingViewController)
 */
class LoadingViewController: UIViewController {
    
    private lazy var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.style = .large
        activityIndicator.color = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height
        let tabBarHeight = super.tabBarController?.tabBar.frame.height
        
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        activityIndicator.center = CGPoint(x: w / 2, y: (h - (navigationBarHeight ?? 0) - (tabBarHeight ?? 0)) / 2.0)
        view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        DispatchQueue.main.async {
            // self?.activityIndicator.
        }
    }
}
