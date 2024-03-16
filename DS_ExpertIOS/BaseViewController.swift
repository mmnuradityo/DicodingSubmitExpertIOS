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
}
