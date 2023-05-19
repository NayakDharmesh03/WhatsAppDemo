//
//  ContactNumber.swift
//  NewAppProject
//
//  Created by NT 2 on 05/05/23.
//

import UIKit

class ContactNumber: NSObject {
    var name:String!
    var contactNo:String!
    var image:UIImage!
    var btnCollspan:Bool!
    var timeLabl:String!
    
    init(strName:String!,strMobileNo:String!,imgPhoto:UIImage,BtnCollspan:Bool!,timeLbl:String){
        
        self.name = strName
        self.contactNo = strMobileNo
        self.image = imgPhoto
        self.btnCollspan = BtnCollspan
        self.timeLabl = timeLbl
    }
}
