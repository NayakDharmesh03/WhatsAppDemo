//
//  GalleryData.swift
//  NewAppProject
//
//  Created by NT 2 on 18/04/23.
//

import Foundation
class  GalleryData: NSObject {
    
    var strTitle : String!
    var imageArr:[String] = []
    
    init(strTitle:String!,images:[String]) {
        self.strTitle = strTitle
        self.imageArr = images
    }
}
