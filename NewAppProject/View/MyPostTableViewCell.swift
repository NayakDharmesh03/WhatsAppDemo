//
//  MyPostTableViewCell.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 24/03/23.
//

import UIKit

class MyPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var manuDotBtn: UIButton!
    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var likebutton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var bookMarkBtn: UIButton!
    
    @IBOutlet weak var likedProfile: UIImageView!
    @IBOutlet weak var likeStastus: UILabel!
    
    @IBOutlet weak var mycollectionview: UICollectionView!
    

    @IBOutlet var pageControl: UIPageControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)

        userProfileImg.layer.cornerRadius = userProfileImg.frame.height/2
        
    }
}
