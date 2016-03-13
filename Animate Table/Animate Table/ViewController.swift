//
//  ViewController.swift
//  Animate Table
//
//  Created by Dinh Le on 11/03/16.
//  Copyright © 2016 Dinh Le. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    
   
    // MARK: private propertise
    
    var isViewFullList: Bool = false
    // MARK: public propertise
    var rawData: NSArray?
    var displayData: NSArray?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Rewind, target: self, action: "backTapped:")
        self.loadListFromFile("ListItem")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backTapped(sender: AnyObject) {
        self.trimTableView()
    }
    
    func showHideNavigationController(show:Bool) {
        if show == true {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        let timeNavigationShowHide = NSTimeInterval(UINavigationControllerHideShowBarDuration)
        UIView.animateWithDuration(timeNavigationShowHide, animations: { () -> Void in
//            if show == true {
//                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x,
//                    self.tabBar.frame.origin.y + self.tabBar.frame.size.height,
//                    self.tabBar.frame.size.width,
//                    self.tabBar.frame.size.height)
//                self.tabBar.hidden = true
//            } else {
//                self.tabBar.hidden = false
//                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x,
//                    self.view.frame.size.height - self.tabBar.frame.size.height,
//                    self.tabBar.frame.size.width,
//                    self.tabBar.frame.size.height)
//            }
            // animation code
            }) { (done) -> Void in
                if done {
                    self.view.setNeedsLayout()
                  //complete animation
            }
        }
    }
    
    private func loadListFromFile(plistFileName:String) {
        let path = NSBundle.mainBundle().pathForResource(plistFileName, ofType: "plist")
        if (path != nil) {
            let rawArray = NSArray(contentsOfFile: path!)
            if (rawArray != nil) {
                self.rawData = rawArray
            }
            self.fillData()
            self.tableView.reloadData()
            //let names: [String] = rootDict?.valueForKeyPath("name")
        }
    }
    
    private func fillData() {
        if (self.isViewFullList == false) {
            if self.rawData?.count > 2 {
                self.displayData = NSArray(array: [self.rawData![0],self.rawData![1]])
            } else {
                self.displayData = self.rawData
            }
            //self.showHideNavigationController(false)
        } else {
            self.displayData = self.rawData
            //self.showHideNavigationController(true)
        }
    }
    
}
extension ViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayData!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dictValueCell = self.displayData![indexPath.row] as? NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("itemListCell", forIndexPath: indexPath) as! ListItemCell
        if (dictValueCell != nil) {
            cell.distanceLabel.text = dictValueCell!["distance"] as? String
            cell.descriptionLabel.text = dictValueCell!["description"] as? String
            cell.nameLabel.text = dictValueCell!["name"] as? String
            cell.iconBranchImageView.image = UIImage(named: (dictValueCell!["icon"] as? String)!)
        }
        if self.isViewFullList == true {
            cell.colapseExpanseCell(false)
        } else {
            cell.colapseExpanseCell(true)
        }
        return cell
    }
    
}

extension ViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (self.isViewFullList == true) {
            return ListItemCell.HEIGHT_LIST_CELL
        } else {
            return ListItemCell.HEIGHT_LIST_CELL_COLAPSE
        }
    }
    
    func trimTableView() {
        let countData = self.displayData?.count
        if (countData > 0) {
            var delRowArray = [NSIndexPath]()
            let beginTail = 2
            if (beginTail < (countData! - 1) ){
                for var index = beginTail; index < countData; ++index {
                    let indexDel = NSIndexPath(forRow: index, inSection:0)
                    delRowArray.append(indexDel)
                }
            }
            self.isViewFullList = false
            self.fillData()
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths(delRowArray, withRowAnimation: UITableViewRowAnimation.Right)
            self.updateLayOutTable(tableView)
            self.tableView.endUpdates()
        }
    }
    func addTableView() {
        let countData = self.rawData?.count
        if (countData > 0) {
            var arrayIndexAdd = [NSIndexPath]()
            let beginTail = 2
            if (beginTail <= (countData! - 1) ){
                for var index = beginTail; index < countData ; ++index {
                    let indexDel = NSIndexPath(forRow: index, inSection: 0)
                    arrayIndexAdd.append(indexDel)
                    
                }
            }
            self.isViewFullList = true
            self.fillData()
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths(arrayIndexAdd, withRowAnimation: UITableViewRowAnimation.Left)
            self.updateLayOutTable(tableView)
            self.tableView.endUpdates()
        }
        
    }
    
    func updateLayOutTable(tableView:UITableView) {
        for cell in tableView.visibleCells as! [ListItemCell] {
            if self.isViewFullList == true {
                cell.colapseExpanseCell(false)
                //self.showHideNavigationController(true)
            } else {
                cell.colapseExpanseCell(true)
                //self.showHideNavigationController(false)
            }
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if self.isViewFullList == false {
            self.addTableView()
        }
    }
}




