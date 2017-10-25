//
//  ViewController.swift
//  test
//
//  Created by Danila Gusev on 25/10/2017.
//  Copyright © 2017 Josshad. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return visibleViewController!.preferredStatusBarStyle
    }
}

class RootViewController:UIViewController{
    
    private var _preferredStyle = UIStatusBarStyle.default;
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return _preferredStyle
        }
        set {
            _preferredStyle = newValue
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
    }
    
    override func viewDidLoad() {
        modalPresentationCapturesStatusBarAppearance = true;
    }
        
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if let last = self.navigationController?.viewControllers.last as? RootViewController{
            if last == self && self.navigationController!.viewControllers.count > 1{
                if let parent = self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - 2] as? RootViewController{
                    parent.setNavigationColors()
                }
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let parent = navigationController?.viewControllers.last as? RootViewController{
            parent.animateNavigationColors()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        self.setNavigationColors()
    }
    
    func animateNavigationColors(){
        self.setBeforePopNavigationColors()
        transitionCoordinator?.animate(alongsideTransition: { [weak self](context) in
            self?.setNavigationColors()
            }, completion: nil)
    }
    
    func setBeforePopNavigationColors() {
        //Override in subclasses
    }
        
    func setNavigationColors(){
        //Override in subclasses
    }
    
}

class FirstViewController: RootViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "First"
    }
    
    
    override func setBeforePopNavigationColors() {
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.preferredStatusBarStyle = UIStatusBarStyle.lightContent
    }
    
    override func setNavigationColors(){
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.preferredStatusBarStyle = UIStatusBarStyle.default
    }
}
class SecondViewController: RootViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Second"
    }
    override func setNavigationColors(){
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.preferredStatusBarStyle = UIStatusBarStyle.lightContent
    }
}
