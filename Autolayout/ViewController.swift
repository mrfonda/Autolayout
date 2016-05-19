//
//  ViewController.swift
//  Autolayout
//
//  Created by Vladislav Dorfman on 18.05.16.
//  Copyright © 2016 Vladislav Dorfman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var loginField: UITextField!

    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    var secure = false { didSet { updateUI() }}
    var loggedInUser: User? { didSet { updateUI() }}
    
    private func updateUI() {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
        name.text = loggedInUser?.name
        company.text = loggedInUser?.company
        image = loggedInUser?.image
    }
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var company: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func toggleSecurity(sender: UIButton) {
        secure = !secure
    }
    
    
    @IBAction func login() {
    loggedInUser = User.login(loginField.text ?? "" , password: passwordField.text ?? "")
    }
    
    var image: UIImage?
    {
        get { return imageView.image }
        set {
            imageView.image = newValue
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRatioConstraint = NSLayoutConstraint(item: constrainedView,
                                                               attribute: .Width,
                                                               relatedBy: .Equal,
                                                               toItem: constrainedView,
                                                               attribute: .Height,
                                                               multiplier: newImage.aspectRatio, constant: 0)
                }

            } else {
                aspectRatioConstraint = nil
            }
        }
        
    }
    var aspectRatioConstraint : NSLayoutConstraint? {
        willSet {
            if let existingConstraint = aspectRatioConstraint {
                view.removeConstraint(existingConstraint)
            }
        }
        didSet {
            if let newConstraint  = aspectRatioConstraint {
                view.addConstraint(newConstraint)
            }
        }
    }
    
}
extension User {
    var image : UIImage? {
        if let image = UIImage(named: login) {
            return image
        } else {
           return UIImage ( named: "unknown_user")
        }
    }
}
extension UIImage
{
    var aspectRatio : CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}
