//
//  ViewController.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 24/04/23.
//


import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]

        // Set the font attributes for the normal state
        segment.setTitleTextAttributes(fontAttributes, for: .normal)

        // Set the font attributes for the selected state if needed
        segment.setTitleTextAttributes(fontAttributes, for: .selected)

    }

    @IBAction func btnMenuBarbuttonItemTapped(_ sender: UIBarButtonItem) {
        let camera = UIAction(title: "Camera", image: UIImage(systemName: "camera")){ _ in
            print("camera tapped")
        }
        let photo = UIAction(title: "Photo", image: UIImage(systemName: "photo.on.rectangle.angled")){ _ in
            print("photo tapped")
        }
        let menu = UIMenu(title: "Welcome!", children: [camera, photo])
        sender.menu = menu
    }
    
    @IBAction func btnMenuTapped(_ sender: UIButton) {
       
        let camera = UIAction(title: "Camera"){ _ in
            print("camera tapped")
        }
        let camera1 = UIAction(title: "Camera"){ _ in
            print("camera tapped")
        }
        let camera2 = UIAction(title: "Camera"){ _ in
            print("camera tapped")
        }
        let camera3 = UIAction(title: "Camera"){ _ in
            print("camera tapped")
        }
        let photo = UIAction(title: "Photo"){ _ in
            print("photo tapped")
        }
        let menu = UIMenu(title: "OptionList!", children: [camera,camera1,camera2,camera3,photo])
        sender.showsMenuAsPrimaryAction = true
        sender.menu = menu
        
    }
    @IBAction func btnDeferredTapped(_ sender: UIButton) {
        let deferredElement = UIDeferredMenuElement { (menuElements) in
            let camera = UIAction(title: "Camera", image: UIImage(systemName: "camera")){ _ in
                print("camera tapped")
            }
            let photo = UIAction(title: "Photo", image: UIImage(systemName: "photo.on.rectangle.angled")){ _ in
                print("photo tapped")
            }
            let menu = UIMenu(title: "Welcome", options: .displayInline ,  children: [camera, photo])
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                menuElements([menu])
            }
        }
        
        let camera = UIAction(title: "Add", image: UIImage(systemName: "plus.circle")){ _ in
            print("camera tapped")
        }
        let photo = UIAction(title: "Edit", image: UIImage(systemName: "pencil.circle")){ _ in
            print("photo tapped")
        }
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "minus.circle"), attributes: .destructive){ _ in
            print("photo tapped")
        }
        
        
        let menu = UIMenu(title: "Welcome!", children: [deferredElement,delete, photo, camera])
        sender.showsMenuAsPrimaryAction = true
        sender.menu = menu
    }
}
