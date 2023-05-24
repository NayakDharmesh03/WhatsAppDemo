//
//  MyGalleryVC.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 23/04/23.
//

import UIKit

class MyGalleryVC: UIViewController {
    
    @IBOutlet weak var mycollectionView: UICollectionView!
    
    var cameraImageArr = ["pexels1","pexels2","pexels3","pexels4","pexels5"]
    var recentImageArr = ["pexels3","pexels1","pexels6","pexels5"]
    var downloadImageArr = ["pexels4","pexels5","pexels3"]
    var favouriteImageArr = ["pexels6","pexels1","pexels2","pexels3","pexels1","pexels2"]
    var Myself = ["pexels5","pexels3","pexels2"]

    var allImageArr = ["pexels1","pexels2","pexels3","pexels4","pexels5","pexels3","pexels1","pexels6","pexels5","pexels4","pexels5","pexels6"]
    
    var categoryArr = ["All Image","Recent","Download","Favourite","Camera"]
    
    var galleryArr : [GalleryData] = []
     
    //tapGesture for hinding manu
    private var tapGesture: UITapGestureRecognizer?

    //creating object of WhatsAppVC
    var WhatsAppView: WhatsAppVC?
    
//MARK: - ViewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Creating objects of all images
        let Obj1 = GalleryData(strTitle: "All Image", images: allImageArr)
        let Obj2 = GalleryData(strTitle: "Recent", images: recentImageArr)
        let Obj3 = GalleryData(strTitle: "Camera", images: cameraImageArr)
        let Obj4 = GalleryData(strTitle: "Download", images: downloadImageArr)
        let Obj5 = GalleryData(strTitle: "Favourite", images: favouriteImageArr)
        let Obj6 = GalleryData(strTitle: "Myself", images: Myself)

        //Appending objects of GalleryArr
        self.galleryArr.append(Obj1)
        self.galleryArr.append(Obj2)
        self.galleryArr.append(Obj3)
        self.galleryArr.append(Obj4)
        self.galleryArr.append(Obj5)
        self.galleryArr.append(Obj6)


        
        //Hiding manuView with tapGesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture?.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture!)

    }
    
    
    //Hiding manuView
    @objc private func handleTap() {
        // Hide your subview here
        WhatsAppView?.hideView()


    }
       
    //In bar status color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // Change this to .default for black text
    }
    
    
}
//MARK: - CollectionViewDelegate and  CollectionViewDataSource

extension MyGalleryVC: UICollectionViewDataSource{
 
//MARK: - numberOfItemsInSection

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryArr.count
    }
    
    
//MARK: - cellForItemAt
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = mycollectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! MyGalleryCell
        
        let obj = self.galleryArr[indexPath.row]
        
        cell.myPhoto.image = UIImage(named: obj.imageArr.randomElement() ?? "Emily")
        cell.titleLbel.text = obj.strTitle
        cell.totalImageLbel.text = "\(obj.imageArr.count)"
        
        return cell
    }
    
    
 
    
    //MARK: - For Header title
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerViewIdentifier", for: indexPath) as? CollectionReusableView else {
            fatalError("Unable to dequeue MyHeaderView")
        }
        headerView.titleLabel.text = "My Albums"
        return headerView
    }
    
}

extension MyGalleryVC : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        WhatsAppView?.hideView()
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CollectionImageVC") as! CollectionImageVC
        
        let obj = self.galleryArr[indexPath.row]
        
        //asing array in other galler sliding array
        nextVC.gallaryImageArr = self.galleryArr[indexPath.row].imageArr
        nextVC.headerTitle = obj.strTitle
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    // This is for Hiding manu view code
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        WhatsAppView?.hideView()
    }
    func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        WhatsAppView?.hideView()

          return true
      }
      
      func collectionViewDidEndMultipleSelectionInteraction(_ collectionView: UICollectionView) {
          WhatsAppView?.hideView()

      }
    
    // When scrolling begins in the collection view
      func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
          WhatsAppView?.hideView()
      }
}

//MARK: -  CollectionView FlowLayout

extension MyGalleryVC : UICollectionViewDelegateFlowLayout{
    
    //MARK:- For cell spacing
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (mycollectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

