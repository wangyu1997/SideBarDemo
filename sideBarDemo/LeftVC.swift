//
//  LeftTableVC.swift
//  sideBarDemo
//
//  Created by wangyu on 12/06/2017.
//  Copyright © 2017 wangyu. All rights reserved.
//

import UIKit

class LeftVC: UIViewController {
    @IBOutlet weak var drawerTabView: UITableView!
    
    var dataArray = [["我的商城","sidebar_business"],["QQ钱包","sidebar_purse"],["个性装扮","sidebar_decoration"],["我的收藏","sidebar_favorit"],["我的相册","sidebar_album"],["我的文件","sidebar_file"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawerTabView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        drawerTabView.delegate = self
        drawerTabView.dataSource = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//Mark -tableview协议
extension LeftVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drawerTableCell", for: indexPath)
        
        cell.imageView?.image = UIImage(named: dataArray[indexPath.row][1])
        cell.textLabel?.text = dataArray[indexPath.row][0]
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
            
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        vc.title = dataArray[indexPath.row][0]
        DrawerMainVC.drawerVC?.LeftViewController(vc)
    }
    
}
