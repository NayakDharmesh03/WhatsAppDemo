//
//  HomeWorkoutTableViewCell.swift
//  NewAppProject
//
//  Created by NT 2 on 12/04/23.
//

import UIKit
import Cosmos
class HomeWorkoutTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cosmosRatingView: CosmosView!
    @IBOutlet weak var cellView: UIView! //subView
    @IBOutlet weak var cellsubView: UIView! //subView
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var sliderValu: UILabel!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet var coloreView: UIView!
    @IBOutlet var progressCurrentValue: UILabel!
    @IBOutlet var progressMaxValue: UILabel!
    
    
//    private let startRating:Float = 0.5

    let sliderMaxvalue = 100
    
    var sliderValueChanged: ((Int) -> Void)?
    var switchValueChanged: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellConfiguration()
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 12)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        mySlider.setThumbImage(image, for: .normal)
        mySlider.setThumbImage(image, for: .highlighted)
        // Increase the height
        let sliderHeight: CGFloat = 8.0
        mySlider.frame.size.height = sliderHeight
        
        coloreView.layer.cornerRadius = 15
        
        mySlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        btnSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        }
        
    
    func cellConfiguration(){
        
        // slider thumb size
        let configuration = UIImage.SymbolConfiguration(pointSize: 18)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        mySlider.setThumbImage(image, for: .normal)
        mySlider.setThumbImage(image, for: .highlighted)
        
        //cell view shadow
        cellsubView.layer.shadowColor = UIColor.black.cgColor
        cellsubView.layer.shadowOffset = CGSize(width: 0, height: 1)
        cellsubView.layer.shadowOpacity = 0.5
        cellsubView.layer.shadowRadius = 4
        cellsubView.layer.cornerRadius = 15
        cellsubView.layer.masksToBounds = false
    }
    

    @objc func sliderValueChanged(_ sender: UISlider) {
        sliderValueChanged?(Int(sender.value))
    }

    @objc func switchValueChanged(_ sender: UISwitch) {
        switchValueChanged?(sender.isOn)
    }
 
    @IBAction func starRattingAction(_ sender: UIButton) {
        
        if star1.isSelected == false{
            star1.isSelected = true
        }else if star1.isSelected == true{
            if star2.isSelected == true || star3.isSelected == true{
                star2.isSelected = false
                star3.isSelected = false
            }
        }
        else if star2.isSelected == true{
            
            if star3.isSelected == true{
                star3.isSelected = false
            }else if star1.isSelected == false{
                star1.isSelected = true
            }
        }else if star3.isSelected == false{
            star1.isSelected = true
            star2.isSelected = true
        }
        else if star3.isSelected == true{
            star3.isSelected = false
        }
        
    }
  
    //------------------------
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
