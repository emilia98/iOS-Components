//
//  CustomTabBarController.swift
//  TabBarChangable
//
//  Created by Emilia Nedyalkova on 28.07.21.
//

import UIKit

class CustomTabBarController: UITabBarController {
    private var firstViewControllers = [UIViewController]()
    private var secondViewControllers = [UIViewController]()
    private let storyboardRef = UIStoryboard(name: "Main", bundle: nil)
    public var isClosed = true
    private var lastSelected: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        (tabBar as? CenterButtonTabBar)?.tabBarController = self
        
        let firstVC = storyboardRef.instantiateViewController(withIdentifier: "FirstViewController")
        firstVC.view.backgroundColor = .red
        let secondVC = storyboardRef.instantiateViewController(withIdentifier: "SecondViewController")
        secondVC.view.backgroundColor = .orange
        firstViewControllers = [ firstVC, secondVC ]
        
        let thirdVC = storyboardRef.instantiateViewController(withIdentifier: "ThirdViewController")
        thirdVC.view.backgroundColor = .blue
        let fourthVC = storyboardRef.instantiateViewController(withIdentifier: "FourthViewController")
        fourthVC.view.backgroundColor = .green
        secondViewControllers = [ thirdVC, fourthVC]
    }
    
    func instantiateSecondGroup() {
        lastSelected = self.selectedViewController
        
        self.viewControllers?.removeAll()
        for vc in secondViewControllers {
            self.viewControllers?.append(vc)
        }
    }
    
    func instantiateFirstGroup() {
        lastSelected = self.selectedViewController
        self.viewControllers?.removeAll()
        for vc in firstViewControllers {
            self.viewControllers?.append(vc)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
