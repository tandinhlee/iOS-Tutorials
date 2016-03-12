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
    
    var viewDetailMode: Bool = false
    // MARK: public propertise
    var rawData: NSArray?
    var displayData: NSArray?
    var selectedIndexPath: NSIndexPath? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadListFromFile("ListItem")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func showHideNavigationController() {
        let isNavigationHiden = self.navigationController?.navigationBarHidden
        if isNavigationHiden == true {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        let timeNavigationShowHide = NSTimeInterval(UINavigationControllerHideShowBarDuration)
        
        UIView.animateWithDuration(timeNavigationShowHide, animations: { () -> Void in
            // animation code
            
            }) { (done) -> Void in
                if done {
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
        if (self.selectedIndexPath != nil) {
          // expand mode
            let previousIndex = self.selectedIndexPath!.row - 1
            if (previousIndex >= 0) {
                // valid previous index
                self.displayData = NSArray(array: [self.rawData![previousIndex],self.rawData![self.selectedIndexPath!.row]])
            } else {
                self.displayData = NSArray(array: [self.rawData![self.selectedIndexPath!.row]])
            }
        } else {
            self.displayData = self.rawData
        }
    }
    
}
extension ViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayData!.count
//        if (self.selectedIndexPath != nil) {
//            return self.displayData!.count + 1
//        } else {
//            return self.displayData!.count
//        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dictValueCell = self.displayData![indexPath.row] as? NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("itemListCell", forIndexPath: indexPath) as! ListItemCell
        if (dictValueCell != nil) {
            cell.distanceLabel.text = dictValueCell!["distance"] as? String
            cell.descriptionLabel.text = dictValueCell!["description"] as? String
            cell.nameLabel.text = dictValueCell!["name"] as? String
            cell.iconBranchImageView.image = UIImage(named: (dictValueCell!["icon"] as? String)!)
            cell.colapseExpanseCell(false)
        }
        return cell
//        if (self.selectedIndexPath != nil) {
//            var dictValueCell = self.displayData![indexPath.row] as? NSDictionary
//            if (indexPath.row == self.selectedIndexPath!.row + 1) {
//                dictValueCell = self.displayData![indexPath.row - 1] as? NSDictionary
//                let cell = tableView.dequeueReusableCellWithIdentifier("itemDetailCell", forIndexPath: indexPath) as! DetailItemCell
//                if (dictValueCell != nil) {
//                    cell.priceLabel.text = dictValueCell!["balance"] as? String
//                }
//                return cell
//            } else {
//                let cell = tableView.dequeueReusableCellWithIdentifier("itemListCell", forIndexPath: indexPath) as! ListItemCell
//                if (dictValueCell != nil) {
//                    cell.distanceLabel.text = dictValueCell!["distance"] as? String
//                    cell.descriptionLabel.text = dictValueCell!["description"] as? String
//                    cell.nameLabel.text = dictValueCell!["name"] as? String
//                    cell.iconBranchImageView.image = UIImage(named: (dictValueCell!["icon"] as? String)!)
//                }
//                cell.colapseExpanseCell(true)
//                return cell
//            }
//            
//        } else {
//            let dictValueCell = self.displayData![indexPath.row] as? NSDictionary
//            let cell = tableView.dequeueReusableCellWithIdentifier("itemListCell", forIndexPath: indexPath) as! ListItemCell
//            if (dictValueCell != nil) {
//                cell.distanceLabel.text = dictValueCell!["distance"] as? String
//                cell.descriptionLabel.text = dictValueCell!["description"] as? String
//                cell.nameLabel.text = dictValueCell!["name"] as? String
//                cell.iconBranchImageView.image = UIImage(named: (dictValueCell!["icon"] as? String)!)
//                cell.colapseExpanseCell(false)
//            }
//            return cell
//        }
    }
    
}

extension ViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (self.selectedIndexPath != nil) {
            return ListItemCell.HEIGHT_LIST_CELL_COLAPSE
        } else {
            return ListItemCell.HEIGHT_LIST_CELL
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (self.selectedIndexPath != nil) {
            self.addTableView(tableView, atIndex: self.selectedIndexPath!)
        } else {
            self.selectedIndexPath = indexPath
            self.trimTableView(tableView, atIndex: indexPath)
        }
    }
    
    func trimTableView(tableView: UITableView, atIndex indexPath:NSIndexPath) {
        let countData = self.displayData?.count
        if (countData > 0) {
            var delRowArray = [NSIndexPath]()
            let beginTail = indexPath.row + 1
            if (beginTail < (countData! - 1) ){
                for var index = countData! - 1; index >= beginTail; --index {
                    let indexDel = NSIndexPath(forRow: index, inSection: indexPath.section)
                    delRowArray.append(indexDel)
                }
            }
            let endHead = indexPath.row - 2
            if endHead >= 0 {
                for var index = endHead; index >= 0; --index {
                    let indexDel = NSIndexPath(forRow: index, inSection: indexPath.section)
                    delRowArray.append(indexDel)
                }
            }
            self.fillData()
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths(delRowArray, withRowAnimation: UITableViewRowAnimation.Right)
            self.tableView.endUpdates()
        }
    }
    func addTableView(tableView: UITableView, atIndex indexPath:NSIndexPath) {
        let countData = self.rawData?.count
        if (countData > 0) {
            var arrayIndexAdd = [NSIndexPath]()
            let endHead = indexPath.row - 2
            if endHead >= 0 {
                for var index = 0; index <= endHead; ++index {
                    let indexDel = NSIndexPath(forRow: index, inSection: indexPath.section)
                    arrayIndexAdd.append(indexDel)
                }
            }
            let beginTail = indexPath.row
            
            if (beginTail <= (countData! - 1) ){
                for var index = beginTail; index < countData! - 1 ; ++index {
                    let indexDel = NSIndexPath(forRow: index, inSection: indexPath.section)
                    arrayIndexAdd.append(indexDel)
                    
                }
            }
            self.selectedIndexPath = nil
            self.fillData()
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths(arrayIndexAdd, withRowAnimation: UITableViewRowAnimation.Left)
            self.tableView.endUpdates()
            
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}




