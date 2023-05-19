//
//  WhatsAppVC.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 23/04/23.
//

import UIKit
import SideMenu

class WhatsAppVC: UIViewController {

    @IBOutlet var manuView: UIView!
    @IBOutlet var btnFloating: UIButton!
    
    @IBOutlet weak var myGalleryViewContainer: UIView!
    
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet weak var mytableView: UITableView!
    var timeArr = ["14:24","14:33","17:52","Yesterday","Yesterday","Yesterday","Yesterday","25/4/2023","25/4/2023","22/4/2023","22/4/2023","18/4/2023","18/4/2023","17/4/2023","16/4/2023","15/4/2023","12/4/2023","12/4/2023"]
    var contactsName = ["Darshan",
                        "Aaradhya",
                        "Aarav",
                        "Aditya",
                        "Avni",
                        "Charlotte",
                        "Akshay",
                        "Dhara",
                        "Dharmesh",
                        "Divya",
                        "Emma",
                        "Evelyn",
                        "Harper",
                        "Isabella",
                        "Ishani",
                        "Kavya",
                        "Meera",
                        "Nandini"]

    var contactsNo = ["+919281736212",
                      "+918978678992",
                      "+917123423510",
                      "+917280009874",
                      "+919999823823",
                      "+919989092383",
                      "+916681736212",
                      "+919280096254",
                      "+919283346232",
                      "+919281736212",
                      "+919374826445",
                      "+919098789654",
                      "+917878987654",
                      "+918909897867",
                      "+916767898789",
                      "+919087654321",
                      "+919008978909",
                      "+918988882332",]
    
    var isExpanded: Bool = false
    
    var selectedIndex = 0
    var lastSelectedIndex = -1
    var isCollapce = false
    var ArrContactNo:[ContactNumber] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manuView.alpha = 0
        myGalleryViewContainer.alpha = 0
        mytableView.estimatedRowHeight = 121
        mytableView.rowHeight = UITableView.automaticDimension
        dropShadow()
        
        segmentControlDesign()
        
        setArrData()
    }
    
//MARK: - Segment control custome design
    
    func segmentControlDesign(){
        
        // Set the selected segment text color to white and font size to 20
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
        ], for: .selected)

        // Set the unselected segment text color to gray and font size to 20
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
        ], for: .normal)
    }
    func dropShadow() {
        manuView.layer.masksToBounds = false
        manuView.layer.shadowColor = UIColor.black.cgColor
        manuView.layer.shadowOpacity = 0.5
        manuView.layer.shadowOffset = .zero
        manuView.layer.shadowRadius = 5
        manuView.layer.shouldRasterize = true
        
    }
   func setArrData(){
        
    let obj = ContactNumber(strName: contactsName[0], strMobileNo: contactsNo[0], imgPhoto: UIImage(named: contactsName[0])!, BtnCollspan: false, timeLbl: timeArr[0])
    let obj1 = ContactNumber(strName: contactsName[1], strMobileNo: contactsNo[1], imgPhoto: UIImage(named: contactsName[1])!, BtnCollspan: false, timeLbl: timeArr[1])
    let obj2 = ContactNumber(strName: contactsName[2], strMobileNo: contactsNo[2], imgPhoto: UIImage(named: contactsName[2])!, BtnCollspan: false, timeLbl: timeArr[2])
    let obj3 = ContactNumber(strName: contactsName[3], strMobileNo: contactsNo[3], imgPhoto: UIImage(named: contactsName[3])!, BtnCollspan: false, timeLbl: timeArr[3])
    let obj4 = ContactNumber(strName: contactsName[4], strMobileNo: contactsNo[4], imgPhoto: UIImage(named: contactsName[4])!, BtnCollspan: false, timeLbl: timeArr[4])
    let obj5 = ContactNumber(strName: contactsName[5], strMobileNo: contactsNo[5], imgPhoto: UIImage(named: contactsName[5])!, BtnCollspan: false, timeLbl: timeArr[5])
    let obj6 = ContactNumber(strName: contactsName[6], strMobileNo: contactsNo[6], imgPhoto: UIImage(named: contactsName[6])!, BtnCollspan: false, timeLbl: timeArr[6])
    let obj7 = ContactNumber(strName: contactsName[7], strMobileNo: contactsNo[7], imgPhoto: UIImage(named: contactsName[7])!, BtnCollspan: false, timeLbl: timeArr[7])
    let obj8 = ContactNumber(strName: contactsName[8], strMobileNo: contactsNo[8], imgPhoto: UIImage(named: contactsName[8])!, BtnCollspan: false, timeLbl: timeArr[8])
    let obj9 = ContactNumber(strName: contactsName[9], strMobileNo: contactsNo[9], imgPhoto: UIImage(named: contactsName[9])!, BtnCollspan: false, timeLbl: timeArr[9])
    let obj10 = ContactNumber(strName: contactsName[10], strMobileNo: contactsNo[10], imgPhoto: UIImage(named: contactsName[10])!, BtnCollspan: false, timeLbl: timeArr[10])
    let obj11 = ContactNumber(strName: contactsName[11], strMobileNo: contactsNo[11], imgPhoto: UIImage(named: contactsName[11])!, BtnCollspan: false, timeLbl: timeArr[11])
    let obj12 = ContactNumber(strName: contactsName[12], strMobileNo: contactsNo[12], imgPhoto: UIImage(named: contactsName[12])!, BtnCollspan: false, timeLbl: timeArr[12])
    let obj13 = ContactNumber(strName: contactsName[13], strMobileNo: contactsNo[13], imgPhoto: UIImage(named: contactsName[13])!, BtnCollspan: false, timeLbl: timeArr[13])
    let obj14 = ContactNumber(strName: contactsName[14], strMobileNo: contactsNo[14], imgPhoto: UIImage(named: contactsName[14])!, BtnCollspan: false, timeLbl: timeArr[14])
    let obj15 = ContactNumber(strName: contactsName[15], strMobileNo: contactsNo[15], imgPhoto: UIImage(named: contactsName[15])!, BtnCollspan: false, timeLbl: timeArr[15])
    let obj16 = ContactNumber(strName: contactsName[16], strMobileNo: contactsNo[16], imgPhoto: UIImage(named: contactsName[16])!, BtnCollspan: false, timeLbl: timeArr[16])
    let obj17 = ContactNumber(strName: contactsName[17], strMobileNo: contactsNo[17], imgPhoto: UIImage(named: contactsName[17])!, BtnCollspan: false, timeLbl: timeArr[17])
//    let obj18 = ContactNumber(strName: contactsName[18], strMobileNo: contactsNo[18], imgPhoto: UIImage(named: contactsName[18])!, BtnCollspan: false, timeLbl: timeArr[18])
    
    ArrContactNo.append(obj)
    ArrContactNo.append(obj1)
    ArrContactNo.append(obj2)
    ArrContactNo.append(obj3)
    ArrContactNo.append(obj4)
    ArrContactNo.append(obj5)
    ArrContactNo.append(obj6)
    ArrContactNo.append(obj7)
    ArrContactNo.append(obj8)
    ArrContactNo.append(obj9)
    ArrContactNo.append(obj10)
    ArrContactNo.append(obj11)
    ArrContactNo.append(obj12)
    ArrContactNo.append(obj13)
    ArrContactNo.append(obj14)
    ArrContactNo.append(obj15)
    ArrContactNo.append(obj16)
    ArrContactNo.append(obj17)
//    ArrContactNo.append(obj18)

    
    }
//    for status bar color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
        
        // if also gallery selected then shoiw gallery view
        if segmentControl.selectedSegmentIndex == 1{
            myGalleryViewContainer.alpha = 1
        }
      
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        manuView.alpha = 0
    }
    
//MARK: - Floating Button Action
    
    @IBAction func btnFloatingAction(_ sender: UIButton) {
        
        let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectedContactsVC") as! SelectedContactsVC
        self.navigationController?.pushViewController(searchVC, animated: true)
    }

//MARK: - Show manu Button Action

    @IBAction func showmanu(_ sender: UIButton) {
        self.manuView.alpha = 1
    }
    @IBAction func showSideBar(_ sender: Any) {
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
                if UIDevice.current.userInterfaceIdiom == .pad{
                    vc.settings.menuWidth = self.view.frame.width - 200
                }else{
                    vc.settings.menuWidth = self.view.frame.width - 80
                }
                vc.settings.presentationStyle = .viewSlideOut
                vc.settings.statusBarEndAlpha = 0
                vc.leftSide = true
                present(vc, animated: true, completion: nil)
        
    }
   
    
    @IBAction func segmentControler(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1{
            self.titleLbl.text = "Gallery"
            self.myGalleryViewContainer.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {
               
            })
        }else{
            self.myGalleryViewContainer.alpha = 0
            self.titleLbl.text = "WhatsApp"

        }
    }
    
    @IBAction func expandCellbtn(_ sender: UIButton) {
        
        guard let cell = self.mytableView.cellForRow(at: IndexPath(row: Int(sender.tag), section: 0)) as? contactTableViewCell else{
            return
        }
        
        let obj = self.ArrContactNo[sender.tag]
        
        self.selectedIndex = sender.tag
        mytableView.deselectRow(at: IndexPath(row: Int(sender.tag), section: 0), animated: false)
        
        if selectedIndex == sender.tag {
            if obj.btnCollspan == true{
                obj.btnCollspan = false
                self.isCollapce = false
            }else{
                obj.btnCollspan = true
                self.isCollapce = true
            }
        }else{
            self.isCollapce = true
        }
        
        
        //this for cell button collspan btn new code
        for i in 0..<ArrContactNo.count {
            ArrContactNo[i].btnCollspan = (i == sender.tag)
        }

        mytableView.reloadData()
    }
}

extension WhatsAppVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! contactTableViewCell
        
        let cellObj = ArrContactNo[indexPath.row]
        
        cell.namelbl.text = cellObj.name
        cell.phoneNoLbl.text = "Phone " + " " + cellObj.contactNo
        cell.profileImage.image = cellObj.image
        cell.timeShowLbl.text = cellObj.timeLabl
        
        cell.selectionStyle = .none
        cell.showbtn.isSelected = cellObj.btnCollspan
        
        cell.showbtn.tag = indexPath.row
        cell.timeShowLbl.tag = indexPath.row
        cell.namelbl.tag = indexPath.row
        cell.phoneNoLbl.tag = indexPath.row
        cell.profileImage.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let obj = ArrContactNo[indexPath.row]
        if self.selectedIndex == indexPath.row && isCollapce == true{
            obj.btnCollspan = true
            return 121
        }else{
            obj.btnCollspan = false
            return 85
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.manuView.alpha = 0
        let obj = ArrContactNo[indexPath.row]
        self.selectedIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: false)
        
        if selectedIndex == indexPath.row {
            if obj.btnCollspan == true{
                obj.btnCollspan = false
                self.isCollapce = false
            }else{
                obj.btnCollspan = true
                self.isCollapce = true
            }
        }else{
            self.isCollapce = true
        }
        
        //this for cell button collspan btn new code
        for i in 0..<ArrContactNo.count {
            ArrContactNo[i].btnCollspan = (i == indexPath.row)
        }

        tableView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.manuView.alpha = 0
    }

}
