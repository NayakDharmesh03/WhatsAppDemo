//
//  PostTableViewCell.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 20/03/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {


    
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ProfileName: UILabel!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var likebutton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var bookMarkBtn: UIButton!
    @IBOutlet weak var likedProfile: UIImageView!
    @IBOutlet weak var likeStastus: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }
}

