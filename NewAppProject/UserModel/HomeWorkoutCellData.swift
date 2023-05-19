//
//  HomeWorkoutCellData.swift
//  NewAppProject
//
//  Created by NT 2 on 27/04/23.
//

import UIKit

class HomeWorkoutCellData: NSObject {
    var arrColors:UIColor!
    var WorkType:String!
    var Switch : Bool
    var rating: Double
    var Slider: Int!
    
    init(arrColors:UIColor!,WorkType:String!,Switch: Bool,Slider:Int!,starview:Double) {
        self.arrColors = arrColors
        self.WorkType = WorkType
        self.Switch = Switch
        self.Slider = Slider
        self.rating = starview
    }

}
