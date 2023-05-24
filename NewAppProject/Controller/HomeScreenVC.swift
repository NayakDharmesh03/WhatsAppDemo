//
//  HomeScreenVC.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 20/03/23.
//

import UIKit
import SideMenu
protocol hideManu {
    func hidemanu(manuView:UIView)
}
class HomeScreenVC: UIViewController {
    
    @IBOutlet var manuView: UIView! //Manu view for three dot in right top corner
    
    @IBOutlet weak var tableview: UITableView!
    
    var arrImages1 = ["pexels1","pexels2","pexels3","pexels4","pexels5"]
    var arrImages2 = ["pexels3","pexels1","pexels6","pexels5"]
    var arrImages3 = ["pexels4","pexels5","pexels6","pexels1","pexels2","pexels3"]
    var arrImages4 = ["pexels6","pexels1","pexels2"]
    var arrImages5 = ["pexels3","pexels1","pexels6","pexels5","pexels4","pexels5","pexels6"]
    
    var ImageArr:[HomeCellImage] = []
    
    //tapGesture for hiding manuview
    private var tapGesture: UITapGestureRecognizer?

    var manudelegate : hideManu?
    override func viewDidLoad() {
        super.viewDidLoad()
        

        manuView.alpha = 0
        dropShadow()
        
        
        //This is Profile name, Location and Post profileImage & PostImage Arrays
        
        let obj1 = HomeCellImage(arrImages: arrImages1, strUserName: "Dharmesh", strLocation: "Mumbai",strUserImg: "Dharmesh",isLike: false, isBookMark: false, currentpage: 0)
        let obj2 = HomeCellImage(arrImages: arrImages2, strUserName: "Aaradhya", strLocation: "Delhi",strUserImg: "Aaradhya",isLike: false, isBookMark: false, currentpage: 0)
        let obj3 = HomeCellImage(arrImages: arrImages4, strUserName: "Sanjana", strLocation: "Jaipur",strUserImg: "Sanjana",isLike: false, isBookMark:false , currentpage: 0)
        let obj4 = HomeCellImage(arrImages: arrImages3, strUserName: "Harper", strLocation: "Amritsar",strUserImg: "Harper",isLike: false, isBookMark:false, currentpage: 0)
        let obj5 = HomeCellImage(arrImages: arrImages5, strUserName: "Ishani", strLocation: "Banglore",strUserImg: "Ishani",isLike: false, isBookMark: false, currentpage: 0)
    
        self.ImageArr.append(obj1)
        self.ImageArr.append(obj2)
        self.ImageArr.append(obj3)
        self.ImageArr.append(obj4)
        self.ImageArr.append(obj5)

        
        //Hiding manuView with tapGesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture?.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture!)
    }
    
    //Hiding manuView
    @objc private func handleTap() {
        // Hide your subview here
        self.manuView.alpha = 0

    }

    //Shadow for manu View
    func dropShadow() {
        manuView.layer.masksToBounds = false
        manuView.layer.shadowColor = UIColor.black.cgColor
        manuView.layer.shadowOpacity = 0.5
        manuView.layer.shadowOffset = .zero
        manuView.layer.shadowRadius = 5
        manuView.layer.shouldRasterize = true
        
    }
    
    //Show manu View Action
    @IBAction func showMnau(_ sender: UIButton) {
        
         let actionButton1 = UIAction(title: "ImageView"){ _ in
             print("actionButton1 tapped")
         }
         let actionButton2 = UIAction(title: "TextView"){ _ in
             print("actionButton2 tapped")
         }
         let actionButton3 = UIAction(title: "UILabel"){ _ in
             print("actionButton3 tapped")
         }
         let actionButton4 = UIAction(title: "TableView"){ _ in
             print("actionButton4 tapped")
         }
         let actionButton5 = UIAction(title: "SideBar"){ _ in
             print("actionButton5 tapped")
         }
        let actionButton6 = UIAction(title: "PageControl"){ _ in
            print("actionButton6 tapped")
        }
         let menu = UIMenu(title: "OptionList!", children: [actionButton1,actionButton2,actionButton3,actionButton4,actionButton5,actionButton6])
         sender.showsMenuAsPrimaryAction = true
         sender.menu = menu
//        self.manuView.alpha = 1
        
    }
    
    //Like btn Action
    @IBAction func likeBtnTapped(_ sender: UIButton) {
        
        let obj = self.ImageArr[sender.tag]
        
        if obj.islike == true{
            obj.islike = false
            sender.isSelected = false
//            sender.setImage(UIImage(named:"heart"), for: .normal)
        }else{
            obj.islike = true
            sender.isSelected = true
//            sender.setImage(UIImage(named:"heart (1)"), for: .selected)
        }

        
    }
    //Comment button Action
    @IBAction func commentBtnTapped(_ sender: UIButton) {
    }
    
    //Share button Action
    @IBAction func shareBtnTapped(_ sender: UIButton) {
    }
    
    //BookMark button Action
    @IBAction func bookmarkBtnTapped(_ sender: UIButton) {
        
        let obj = self.ImageArr[sender.tag]
        if obj.isbookMark == true{
            obj.isbookMark = false
            sender.isSelected = false
//            sender.setImage(UIImage(named:"bookmark"), for: .normal)
        }else
        {
            obj.isbookMark = true
            sender.isSelected = true
        }
        
    }
    
    //Sidebar show and hide buton Action
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
    
    //when we touches anywhere then subview hide if sub opened
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        manuView.alpha = 0
    }
}

//MARK: - Home screen UITableViewDataSource and UITableViewDelegate

extension HomeScreenVC:UITableViewDataSource,UITableViewDelegate{
    
   
//MARK: - numberOfRowsInSection DataSource mathod

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImageArr.count
    }

//MARK: - cellForRowAt DataSource mathod
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell") as! MyPostTableViewCell
        
        let obj = self.ImageArr[indexPath.row]
        cell.mycollectionview.delegate = self
        cell.mycollectionview.dataSource = self
        cell.mycollectionview.tag = indexPath.row
        cell.mycollectionview.reloadData()
        
        cell.locationLbl.text = obj.strLocation
        cell.userNameLbl.text = obj.strUserName
        cell.likebutton.isSelected = obj.islike
        cell.bookMarkBtn.isSelected = obj.isbookMark
        cell.pageControl.currentPage = obj.currentPageNo
        cell.userProfileImg.image = UIImage(named: obj.strUserImg)
        cell.pageControl.numberOfPages = obj.arrImages.count
        cell.bookMarkBtn.tag = indexPath.row
        cell.likebutton.tag = indexPath.row

//        tableview.reloadRows(at: [indexPath], with: .none)
//        tableview.deleteRows(at: [indexPath], with: .automatic)

        return cell
    }
    
    //------------------------new code for hiding view
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.manuView.alpha = 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.manuView.alpha = 0
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
            tapGesture?.isEnabled = false
    }
        
        func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
            tapGesture?.isEnabled = true
    }
    

}

//MARK: - This is for CollectionView UICollectionViewDelegate,UICollectionViewDataSource

extension HomeScreenVC:UICollectionViewDataSource{
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.ImageArr[collectionView.tag].arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! HomeImageCollectionViewCell

        let obj = self.ImageArr[collectionView.tag]
        cell.homeImages.image = UIImage(named: obj.arrImages[indexPath.item])
        
        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension HomeScreenVC : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cellTbl = self.tableview.cellForRow(at: IndexPath(row: collectionView.tag, section: 0)) as? MyPostTableViewCell else {
            return
        }
        self.ImageArr[collectionView.tag].currentPageNo = indexPath.item
        cellTbl.pageControl.currentPage = indexPath.item
        
    }
    
    //wiping images with page controll
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            if let collectionView = scrollView as? UICollectionView,
               let cellTbl = self.tableview.cellForRow(at: IndexPath(row: collectionView.tag, section: 0)) as? MyPostTableViewCell {
                
                let pageWidth = collectionView.bounds.width
                let currentPage = targetContentOffset.pointee.x / pageWidth
                
                if velocity.x > 0 {
                    // Swiping to the right
                    cellTbl.pageControl.currentPage = Int(ceil(currentPage))
                } else if velocity.x < 0 {
                    // Swiping to the left
                    cellTbl.pageControl.currentPage = Int(floor(currentPage))
                } else {
                    // Not swiping or swiping slowly
                    cellTbl.pageControl.currentPage = Int(round(currentPage))
                }
            }
        }
}
// MARK: - UICollectionViewDelegateFlowLayout

extension HomeScreenVC: UICollectionViewDelegateFlowLayout{
    
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
