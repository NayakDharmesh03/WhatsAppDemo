//
//  ViewController.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 24/04/23.
//


import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var customSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    

        // Usage example
        let email = "1example@example.co"
        if isValidEmail(email) {
            print("Valid email")
        } else {
            print("Invalid email")
        }
//
//        // Increase the height
//                let sliderHeight: CGFloat = 10.0
//                customSlider.frame.size.height = sliderHeight
//
//                // Adjust the thumb position to align with the increased height
//                let thumbRect = customSlider.thumbRect(forBounds: customSlider.bounds, trackRect: customSlider.trackRect(forBounds: customSlider.bounds), value: customSlider.value)
//                customSlider.frame.origin.y = thumbRect.origin.y + (thumbRect.size.height - sliderHeight)/2
//
//        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
//
//        // Set the font attributes for the normal state
//        segment.setTitleTextAttributes(fontAttributes, for: .normal)
//
//        // Set the font attributes for the selected state if needed
//        segment.setTitleTextAttributes(fontAttributes, for: .selected)

    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
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
