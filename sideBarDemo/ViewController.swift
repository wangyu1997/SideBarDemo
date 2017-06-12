//
//  ViewController.swift
//  sideBarDemo
//
//  Created by wangyu on 12/06/2017.
//  Copyright © 2017 wangyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    
    }

    @IBAction func showAlert(_ sender: UIBarButtonItem) {
        let pop = PopViewController()
        
        pop.modalPresentationStyle = .popover
        pop.popoverPresentationController?.barButtonItem = sender
        pop.popoverPresentationController?.delegate = self
        present(pop, animated: true, completion: {
         action in

        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openOrCloseSider(_ sender: UIBarButtonItem) {
        DrawerMainVC.drawerVC?.openSideBar()
    }

}


extension ViewController: UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}

