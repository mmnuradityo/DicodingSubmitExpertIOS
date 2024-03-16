//
//  GeneralViews.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import UIKit

extension UIViewController {
  func addToSubView(_ stackView: UIStackView, items views: UIView...) {
    for view in views {
      stackView.addArrangedSubview(view)
    }
    view.addSubview(stackView)
  }
  
  func addToSubView(items views: UIView...) {
    for view in views {
      self.view.addSubview(view)
    }
  }
  
  func barBtnBack() -> UIBarButtonItem {
    return UIBarButtonItem(
      title: "back",
      image: UIImage(systemName: "arrow.backward"),
      target: self,
      action: #selector(backAction)
    )
  }
  
  @objc func backAction() {
    dismiss(animated: true, completion: nil)
  }
  
  func displayToast(_ message: String, width: CGFloat) {
    guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else {
      return
    }
    if let toast = window.subviews.first(where: { $0 is UILabel && $0.tag == -1001 }) {
      toast.removeFromSuperview()
    }
    
    let toastView = UILabel()
    toastView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    toastView.textColor = UIColor.white
    toastView.textAlignment = .center
    toastView.font = UIFont(name: "Font-name", size: 17)
    toastView.layer.cornerRadius = 25
    toastView.text = message
    toastView.numberOfLines = 0
    toastView.alpha = 0
    toastView.translatesAutoresizingMaskIntoConstraints = false
    toastView.tag = -1001
    
    window.addSubview(toastView)
    
    let horizontalCenterContraint: NSLayoutConstraint = NSLayoutConstraint(
      item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0
    )
    
    let widthContraint: NSLayoutConstraint = NSLayoutConstraint(
      item: toastView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: width - 25
    )
    
    let verticalContraint: [NSLayoutConstraint] = NSLayoutConstraint.constraints(
      withVisualFormat: "V:|-(>=200)-[toastView(==50)]-68-|", options: [.alignAllCenterX, .alignAllCenterY], metrics: nil, views: ["toastView": toastView]
    )
    
    NSLayoutConstraint.activate([horizontalCenterContraint, widthContraint])
    NSLayoutConstraint.activate(verticalContraint)
    
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
      toastView.alpha = 1
    }, completion: nil)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
      UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
        toastView.alpha = 0
      }, completion: { _ in
        toastView.removeFromSuperview()
      })
    })
  }
  
}
