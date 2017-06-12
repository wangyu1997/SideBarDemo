//
//  DrawerMainVC.swift
//  sideBarDemo
//
//  Created by wangyu on 12/06/2017.
//  Copyright © 2017 wangyu. All rights reserved.
//

import UIKit

class DrawerMainVC: UIViewController {
    
    var mainVC: UIViewController?
    var leftVC: UIViewController?
    
    let maxWith = Constant.DrawerMaxWidth
    
    //Mark -单例
    static let drawerVC = UIApplication.shared.keyWindow?.rootViewController as? DrawerMainVC
    
    init(leftVC:UIViewController,mainVC:UIViewController){
        super.init(nibName: nil, bundle: nil)
        
        self.leftVC = leftVC
        self.mainVC = mainVC
        
        self.view.addSubview(leftVC.view)
        self.view.addSubview(mainVC.view)
        
        addChildViewController(leftVC)
        addChildViewController(mainVC)
        
        for childVC in mainVC.childViewControllers{
            addEdgeGesture(view: childVC.view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftVC?.view.transform = CGAffineTransform(translationX: -maxWith/2, y: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Mark -添加边缘事件
    func addEdgeGesture(view:UIView?) {
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(openWithGuesture(_:)))
        pan.edges = .left
        view?.addGestureRecognizer(pan)
    }
    
    //Mark -展开sidebar事件
    func openWithGuesture(_ pan: UIScreenEdgePanGestureRecognizer) {
        let offsetX = pan.translation(in: pan.view).x
        
        if pan.state == .changed && offsetX <= maxWith{
            self.leftVC?.view.transform = CGAffineTransform(translationX: (offsetX-self.maxWith)/2, y: 0)
            self.mainVC?.view.transform = CGAffineTransform(translationX: offsetX, y: 0)
        }else if pan.state == .cancelled || pan.state == .ended || pan.state == .failed{
            if offsetX >= maxWith/2 {
                openSideBar()
            }else{
                closeSideBar()
            }
        }
    }
    
    //Mark -关闭sidebar事件
    func closeWithGuesture(_ pan: UIPanGestureRecognizer) {
        let offsetX = pan.translation(in: pan.view).x
        if offsetX > 0 {
            return
        }
        
        if pan.state == .changed && offsetX <= maxWith{
            self.leftVC?.view.transform = CGAffineTransform(translationX: offsetX/2, y: 0)
            self.mainVC?.view.transform = CGAffineTransform(translationX: offsetX+self.maxWith, y: 0)
        }else if pan.state == .cancelled || pan.state == .ended || pan.state == .failed{
            if -offsetX >= maxWith/2 {
                closeSideBar()
            }else{
                openSideBar()
            }
        }
    }
    
    //Mark -打开侧滑栏
    func openSideBar(){
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            self.leftVC?.view.transform = CGAffineTransform.identity
            self.mainVC?.view.transform = CGAffineTransform(translationX: self.maxWith, y: 0)
        }, completion: {
            (finish: Bool) in
            self.mainVC?.view.addSubview(self.coverBtn)
        })
    }
    
    //Mark -关闭侧滑栏
    func closeSideBar(){
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            self.leftVC?.view.transform = CGAffineTransform(translationX: -self.maxWith/2, y: 0)
            self.mainVC?.view.transform = CGAffineTransform.identity
        }, completion: {
            (finish: Bool) in
            self.coverBtn.removeFromSuperview()
        })
    }
    
    func LeftViewController(_ viewController:UIViewController){
        guard let tabVC = mainVC as? UITabBarController,
        let nav = tabVC.selectedViewController as? UINavigationController
            else{
                return
        }
        
        viewController.hidesBottomBarWhenPushed = true
        nav.pushViewController(viewController, animated: false)
        closeSideBar()
    }
    
    private lazy var coverBtn: UIButton = {
       let coverBtn = UIButton(frame: Constant.screenBounds)
        coverBtn.backgroundColor = .black
        coverBtn.alpha = 0.2
        coverBtn.addTarget(self, action: #selector(closeSideBar), for: .touchUpInside)
        coverBtn.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(closeWithGuesture(_:))))
        
        return coverBtn
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension DrawerMainVC:UIPopoverControllerDelegate{
    
}
