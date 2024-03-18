//
//  ProfileViewController.swift
//  DS_PengenalanIos
//
//  Created by Admin on 03/09/23.
//
import UIKit

class ProfileViewController: UIViewController {
  
  private let presenter: ProfilePresenter
  private let imgSize: CGFloat = 150
  
  let stackView = UIStackView()
  let lableName = UILabel()
  let lableFrom = UILabel()
  let lableDisc = UILabel()
  let ivProfile = UIImageView()
  
  init(presenter: ProfilePresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    styling()
    layouting()
    onDataSet()
  }
  
  func onDataSet() {
    navigationItem.title = "Profile"
    navigationItem.setRightBarButtonItems([
      UIBarButtonItem(
        title: "Edit",
        style: .plain,
        target: self,
        action: #selector(handleEditProfile)
      )
    ], animated: false)
    
    presenter.$userModel
      .sink { userModel in
        if let userModel = userModel {
          if let avatar = userModel.avatar {
            self.ivProfile.image = UIImage(data: avatar)
          }
          self.lableName.text = userModel.fullName()
          self.lableFrom.text = "Kota asal : \(userModel.address)"
          self.lableDisc.text = "Description : \(userModel.description)"
          
        }
      }
      .store(in: &presenter.cancellables)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getUser()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ProfileViewController {
  func styling() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 20
    
    ivProfile.translatesAutoresizingMaskIntoConstraints = false
    ivProfile.contentMode = .scaleAspectFit
    ivProfile.layer.borderWidth = 1
    ivProfile.layer.masksToBounds = false
    ivProfile.layer.borderColor = UIColor.black.cgColor
    ivProfile.layer.cornerRadius = imgSize / 2
    ivProfile.clipsToBounds = true
    
    lableName.translatesAutoresizingMaskIntoConstraints = false
    lableName.font = UIFont.preferredFont(forTextStyle: .title3)
    lableName.numberOfLines = 0
    
    lableFrom.translatesAutoresizingMaskIntoConstraints = false
    lableFrom.font = UIFont.preferredFont(forTextStyle: .caption1)
    lableFrom.numberOfLines = 0
    
    lableDisc.translatesAutoresizingMaskIntoConstraints = false
    lableDisc.font = UIFont.preferredFont(forTextStyle: .caption1)
    lableDisc.numberOfLines = 0
  }
  
  func layouting() {
    addToSubView(stackView, items: ivProfile, lableName, lableFrom, lableDisc)
    
    NSLayoutConstraint.activate([
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 6),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 6),
      
      ivProfile.widthAnchor.constraint(equalToConstant: imgSize),
      ivProfile.heightAnchor.constraint(equalToConstant: imgSize)
    ])
  }
}

extension ProfileViewController {
  @objc func handleEditProfile(sender: UIBarButtonItem) {
    let editProfileViewController = presenter.router.makeEditProfileViewController()
    present(editProfileViewController, animated: true)
  }
}
