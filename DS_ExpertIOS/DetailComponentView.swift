//
//  DetailComponentView.swift
//  DS_ExpertIOS
//
//  Created by Admin on 21/01/24.
//

import UIKit

class DetailComponentView: UIView {
  private let stackView = UIStackView()
  let labelTitle = UILabel()
  let btnFavorite = UIButton(type: .custom)
  let titleContent = UIView()
  let labelReleaseDate = UILabel()
  let labelRating = UILabel()
  let labelGenre = UILabel()
  let labelReview = UILabel()
  
  let space = CGFloat(18)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func createDivider() -> UIView {
    let divider = UIView()
    divider.translatesAutoresizingMaskIntoConstraints = false
    divider.backgroundColor = .systemFill
    
    NSLayoutConstraint.activate([
      divider.heightAnchor.constraint(equalToConstant: 1)
    ])
    
    return divider
  }
}

extension DetailComponentView {
  func style() {
    translatesAutoresizingMaskIntoConstraints = false
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fill
    stackView.axis = .vertical
    stackView.spacing = 8
    
    labelTitle.translatesAutoresizingMaskIntoConstraints = false
    labelTitle.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    labelTitle.numberOfLines = 0
    
    btnFavorite.translatesAutoresizingMaskIntoConstraints = false
    btnFavorite.imageView?.contentMode = .scaleAspectFill
    
    titleContent.translatesAutoresizingMaskIntoConstraints = false
    
    setCaption(lable: labelReleaseDate)
    setCaption(lable: labelRating)
    setCaption(lable: labelGenre)
    setCaption(lable: labelReview)
  }
  
  func setCaption(lable: UILabel) {
    lable.translatesAutoresizingMaskIntoConstraints = false
    lable.font = UIFont.preferredFont(forTextStyle: .caption2)
    lable.adjustsFontForContentSizeCategory = true
    lable.numberOfLines = 0
  }
  
  func layout() {
    titleContent.addSubview(labelTitle)
    titleContent.addSubview(btnFavorite)
    
    addView()
    
    NSLayoutConstraint.activate([
      labelTitle.topAnchor.constraint(equalTo: titleContent.topAnchor),
      labelTitle.bottomAnchor.constraint(equalTo: titleContent.bottomAnchor),
      labelTitle.leadingAnchor.constraint(equalTo: titleContent.leadingAnchor),
      labelTitle.trailingAnchor.constraint(equalTo: btnFavorite.leadingAnchor),
      
      btnFavorite.topAnchor.constraint(equalTo: titleContent.topAnchor),
      btnFavorite.bottomAnchor.constraint(equalTo: titleContent.bottomAnchor),
      btnFavorite.leadingAnchor.constraint(equalTo: labelTitle.trailingAnchor, constant: space),
      btnFavorite.trailingAnchor.constraint(equalTo: titleContent.trailingAnchor),
      
      stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
      trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
      bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
    ])
  }
  
  func addView() {
    stackView.addArrangedSubview(titleContent)
    stackView.setCustomSpacing(space, after: titleContent)
    
    stackView.addArrangedSubview(labelReleaseDate)
    stackView.addArrangedSubview(createDivider())
    
    stackView.addArrangedSubview(labelRating)
    stackView.addArrangedSubview(createDivider())
    
    stackView.addArrangedSubview(labelGenre)
    stackView.addArrangedSubview(createDivider())
    
    stackView.addArrangedSubview(labelReview)
    stackView.addArrangedSubview(createDivider())
    
    addSubview(stackView)
  }
}
