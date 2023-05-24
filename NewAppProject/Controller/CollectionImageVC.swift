//
//  CollectionImageVC.swift
//  NewAppProject
//
//  Created by NT 2 on 13/04/23.
//

import UIKit

class CollectionImageVC: UIViewController {
    @IBOutlet var manu: UIView!
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var previousBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    
    @IBOutlet var imageCountlbl: UILabel!
    @IBOutlet var collectionview: UICollectionView!
    
    var imageName = ""
    var headerTitle = ""
    var gallaryImageArr : [String] = []
    
    var totalImage = 0
    var currentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropShadow()
        manu.alpha = 0
        titleLbl.text = headerTitle
        imageCountlbl.text = "\(currentIndex+1)" + "/" + "\(gallaryImageArr.count)"
        totalImage = gallaryImageArr.count
    }
    func dropShadow() {
        manu.layer.masksToBounds = false
        manu.layer.shadowColor = UIColor.black.cgColor
        manu.layer.shadowOpacity = 0.5
        manu.layer.shadowOffset = .zero
        manu.layer.shadowRadius = 5
        manu.layer.shouldRasterize = true
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // Change this to .default for black text
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.manu.alpha = 0
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func showManu(_ sender: UIButton) {
//        manu.alpha = 1
        
         let actionButton1 = UIAction(title: "ImageView"){ _ in
             print("actionButton1 tapped")
         }
         let actionButton2 = UIAction(title: "TextView"){ _ in
             print("actionButton2 tapped")
         }
         let actionButton3 = UIAction(title: "UILabel"){ _ in
             print("actionButton3 tapped")
         }
         let actionButton4 = UIAction(title: "CollectionView"){ _ in
             print("actionButton4 tapped")
         }
         let actionButton5 = UIAction(title: "UIButton"){ _ in
             print("actionButton5 tapped")
         }
         let menu = UIMenu(title: "OptionList!", children: [actionButton1,actionButton2,actionButton3,actionButton4,actionButton5])
         sender.showsMenuAsPrimaryAction = true
         sender.menu = menu
        
    }
    
    //nextButtonTapped Action
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        nextBtn.isEnabled = currentIndex < totalImage - 1
        
        if currentIndex < gallaryImageArr.count - 1 {
            currentIndex += 1
            imageCountlbl.text = "\(currentIndex + 1)/\(gallaryImageArr.count)"
            collectionview.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
    
    //previousButtonTapped Action
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        previousBtn.isEnabled = currentIndex > 0
        if currentIndex > 0 {
            currentIndex -= 1
            imageCountlbl.text = "\(currentIndex + 1)/\(gallaryImageArr.count)"
            collectionview.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
    
    
}

extension CollectionImageVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallaryImageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mycell = collectionview.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! ImageCollectionViewCell
        mycell.images.image = UIImage(named: gallaryImageArr[indexPath.row] )
        
        nextBtn.isEnabled = currentIndex < totalImage - 1
        
        previousBtn.isEnabled = currentIndex > 0
        
        imageCountlbl.text = "\(currentIndex+1)" + "/" + "\(gallaryImageArr.count)"
        
        
        return mycell
    }
    
    
    // This is sliding images us
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionview.contentOffset, size: collectionview.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionview.indexPathForItem(at: visiblePoint) else {
            return
        }
        
        currentIndex = indexPath.item
        imageCountlbl.text = "\(currentIndex + 1)/\(gallaryImageArr.count)"
        
        nextBtn.isEnabled = currentIndex < totalImage - 1
        previousBtn.isEnabled = currentIndex > 0
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            
            let contentOffset = scrollView.contentOffset.x
            let contentWidth = scrollView.contentSize.width
            let pageWidth = scrollView.bounds.width
            let currentPage = currentIndex
            let nextPage = contentOffset > CGFloat(currentPage) * pageWidth ? (currentPage + 1) % gallaryImageArr.count : (currentPage - 1 + gallaryImageArr.count) % gallaryImageArr.count
            let nextX = CGFloat(nextPage) * pageWidth
            let distance = abs(contentOffset - nextX)
            let duration = TimeInterval(distance / pageWidth * 0.3)
            currentIndex = nextPage
            UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut], animations: {
                
                self.nextBtn.isEnabled = self.currentIndex < self.totalImage - 1
                self.previousBtn.isEnabled = self.currentIndex > 0
                
                scrollView.contentOffset.x = nextX
            }, completion: nil)
        }
    }
    
    
}

extension CollectionImageVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
}
