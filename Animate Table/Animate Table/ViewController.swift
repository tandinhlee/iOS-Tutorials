//
//  ViewController.swift
//  Animate Table
//
//  Created by Dinh Le on 11/03/16.
//  Copyright © 2016 Dinh Le. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    static let HEIGHT_LIST_CELL = CGFloat(96)
    static let HEIGHT_LIST_CELL_COLAPSE = CGFloat(96)
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
            }
        } else {
            self.displayData = self.rawData
        }
    }
    
}
extension ViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.selectedIndexPath != nil) {
            return self.displayData!.count + 1
        } else {
            return self.displayData!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (self.selectedIndexPath != nil) {
            var dictValueCell = self.displayData![indexPath.row] as? NSDictionary
            if (indexPath.row == self.selectedIndexPath!.row + 1) {
                dictValueCell = self.displayData![indexPath.row - 1] as? NSDictionary
                let cell = tableView.dequeueReusableCellWithIdentifier("itemDetailCell", forIndexPath: indexPath) as! DetailItemCell
                if (dictValueCell != nil) {
                    cell.priceLabel.text = dictValueCell!["balance"] as? String
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("itemListCell", forIndexPath: indexPath) as! ListItemCell
                if (dictValueCell != nil) {
                    cell.distanceLabel.text = dictValueCell!["distance"] as? String
                    cell.descriptionLabel.text = dictValueCell!["description"] as? String
                    cell.nameLabel.text = dictValueCell!["name"] as? String
                    cell.iconBranchImageView.image = UIImage(named: (dictValueCell!["icon"] as? String)!)
                }
                return cell
            }
            
        } else {
            let dictValueCell = self.displayData![indexPath.row] as? NSDictionary
            let cell = tableView.dequeueReusableCellWithIdentifier("itemListCell", forIndexPath: indexPath) as! ListItemCell
            if (dictValueCell != nil) {
                cell.distanceLabel.text = dictValueCell!["distance"] as? String
                cell.descriptionLabel.text = dictValueCell!["description"] as? String
                cell.nameLabel.text = dictValueCell!["name"] as? String
                cell.iconBranchImageView.image = UIImage(named: (dictValueCell!["icon"] as? String)!)
            }
            return cell
        }
    }
    
}

extension ViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ViewController.HEIGHT_LIST_CELL
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}




