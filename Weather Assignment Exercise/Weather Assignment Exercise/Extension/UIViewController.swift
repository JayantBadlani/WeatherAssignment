//
//  UIViewController.swift

import Foundation
import UIKit

extension UIViewController
{
    //MARK: Common Methods
    func add(_ child: UIViewController) {
        
        DispatchQueue.main.async {
            self.addChild(child)
            self.view.addSubview(child.view)
            
            child.didMove(toParent: self)
        }
    }
    
    func remove()
    {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func showAlert(titl:String = "Weather", msg :String)
    {
        let alert = UIAlertController(title: titl, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
}
