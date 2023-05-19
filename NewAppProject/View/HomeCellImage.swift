//
//  HomeCellImage.swift
//  NewAppProject
//
//  Created by NT 2 on 26/04/23.
//

import UIKit

class HomeCellImage: NSObject {
    
    var arrImages : [String] = []
    var strUserName : String!
    var strLocation : String!
    var strUserImg : String!
    var islike : Bool!
    var isbookMark : Bool!
    var currentPageNo : Int!
    
    init(arrImages: [String],strUserName : String!,strLocation : String!, strUserImg : String!,isLike : Bool!,isBookMark : Bool!,currentpage : Int!) {
        self.arrImages = arrImages
        self.strUserName = strUserName
        self.strLocation = strLocation
        self.strUserImg = strUserImg
        self.islike = isLike
        self.isbookMark = isBookMark
        self.currentPageNo = currentpage
    }
}
