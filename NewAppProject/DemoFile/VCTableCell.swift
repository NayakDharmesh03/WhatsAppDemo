//
//  VCTableCell.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 24/04/23.
//

import UIKit

class VCTableCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView! //subView
    
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var sliderValu: UILabel!
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progresbarMaxValue: UILabel!
    @IBOutlet weak var progresBarCurentValue: UILabel!
    
   
    @IBOutlet weak var colorview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorview.layer.cornerRadius = 15

        // slider thumb size
        let configuration = UIImage.SymbolConfiguration(pointSize: 15)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        Slider.setThumbImage(image, for: .normal)
        Slider.setThumbImage(image, for: .highlighted)
        
        //cell view shadow
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0, height: 1)
        cellView.layer.shadowOpacity = 0.5
        cellView.layer.shadowRadius = 4
        cellView.layer.cornerRadius = 15
        cellView.layer.masksToBounds = false

    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
