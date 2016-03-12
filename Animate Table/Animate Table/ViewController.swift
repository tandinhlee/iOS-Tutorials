//
//  ViewController.swift
//  Animate Table
//
//  Created by Dinh Le on 11/03/16.
//  Copyright © 2016 Dinh Le. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    static let HEIGHT_LIST_CELL = CGFloat(44)
    static let HEIGHT_LIST_CELL_EXPAND = CGFloat(96)
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tableView: UITableView!
    // MARK: private propertise
    
    var viewDetailMode:Bool = false
    
    // MARK: public propertise

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
            let rootDict = NSArray(contentsOfFile: path!)
            if (rootDict != nil) {
                let names = rootDict?.valueForKeyPath("name") as? [String]
                if (names != nil) {
                    for itemName  in names! {
                        debugPrint("Branch : \(itemName)")
                    }
                }
            }
            //let names: [String] = rootDict?.valueForKeyPath("name")
        }
    }
    
}
extension ViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemListCell", forIndexPath: indexPath)
        cell.textLabel?.text = "cell at \(indexPath.row)"
        return cell;
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




