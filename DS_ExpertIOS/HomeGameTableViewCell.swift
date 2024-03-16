//
//  GameTableViewCell.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//
import UIKit

class HomeGameTableViewCell: UITableViewCell {
  static let cellIdentifier = "GameTableViewCell"
  static let rowHight: CGFloat = 150
  private let imgSize: CGFloat = 120
  private let favSize: CGFloat = 32
  
  let labelName = UILabel()
  let labelIndicatorReleaseDate = UILabel()
  let labelReleaseDate = UILabel()
  let labelIndicatorRating = UILabel()
  let labelRating = UILabel()
  let ivImage = UIImageView()
  let ivFavorite = UIImageView()
  let divider = UIView()
  let indicatorLoading = UIActivityIndicatorView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
    layout()
    setDefautValue()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeGameTableViewCell {
  func setup() {
    ivImage.translatesAutoresizingMaskIntoConstraints = false
    ivImage.contentMode = .scaleAspectFill
    ivImage.layer.masksToBounds = false
    ivImage.layer.cornerRadius = 10
    ivImage.clipsToBounds = true
    
    ivFavorite.translatesAutoresizingMaskIntoConstraints = false
    ivFavorite.contentMode = .center
    ivFavorite.layer.masksToBounds = false
    ivFavorite.layer.cornerRadius = favSize / 2
    ivFavorite.backgroundColor = UIColor.white
    ivFavorite.clipsToBounds = true
    ivFavorite.layer.borderColor = UIColor.red.cgColor
    ivFavorite.layer.borderWidth = 1
    ivFavorite.isHidden = true
    
    indicatorLoading.translatesAutoresizingMaskIntoConstraints = false
    
    labelName.translatesAutoresizingMaskIntoConstraints = false
    labelName.font = UIFont.preferredFont(forTextStyle: .title3)
    labelName.adjustsFontForContentSizeCategory = true
    labelName.adjustsFontSizeToFitWidth = false
    labelName.numberOfLines = 0
    
    divider.translatesAutoresizingMaskIntoConstraints = false
    divider.backgroundColor = .systemFill
    
    setCaption(lable: labelIndicatorReleaseDate)
    setCaption(lable: labelReleaseDate)
    setCaption(lable: labelIndicatorRating)
    setCaption(lable: labelRating)
  }
  
  func setCaption(lable: UILabel) {
    lable.translatesAutoresizingMaskIntoConstraints = false
    lable.font = UIFont.preferredFont(forTextStyle: .caption1)
    lable.adjustsFontForContentSizeCategory = true
    lable.numberOfLines = 0
  }
  
  func layout() {
    addToSubView(
      items:
        ivImage,
      ivFavorite,
      indicatorLoading,
      labelName,
      labelIndicatorReleaseDate,
      labelReleaseDate,
      divider,
      labelIndicatorRating,
      labelRating
    )
    
    NSLayoutConstraint.activate([
      ivImage.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
      labelName.leadingAnchor.constraint(equalToSystemSpacingAfter: ivImage.trailingAnchor, multiplier: 2),
      ivImage.centerYAnchor.constraint(equalTo: centerYAnchor),
      ivImage.widthAnchor.constraint(equalToConstant: imgSize),
      ivImage.heightAnchor.constraint(equalToConstant: imgSize),
      
      ivFavorite.trailingAnchor.constraint(equalToSystemSpacingAfter: ivImage.trailingAnchor, multiplier: 1),
      ivFavorite.bottomAnchor.constraint(equalToSystemSpacingBelow: ivImage.bottomAnchor, multiplier: 1),
      ivFavorite.widthAnchor.constraint(equalToConstant: favSize),
      ivFavorite.heightAnchor.constraint(equalToConstant: favSize),
      
      indicatorLoading.topAnchor.constraint(equalTo: ivImage.topAnchor),
      indicatorLoading.bottomAnchor.constraint(equalTo: ivImage.bottomAnchor),
      indicatorLoading.leadingAnchor.constraint(equalTo: ivImage.leadingAnchor),
      indicatorLoading.trailingAnchor.constraint(equalTo: ivImage.trailingAnchor),
      
      labelName.topAnchor.constraint(equalTo: ivImage.topAnchor),
      labelName.leadingAnchor.constraint(equalToSystemSpacingAfter: ivImage.trailingAnchor, multiplier: 2),
      trailingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: labelName.trailingAnchor, multiplier: 2),
      
      labelIndicatorReleaseDate.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10),
      labelIndicatorReleaseDate.leadingAnchor.constraint(equalToSystemSpacingAfter: ivImage.trailingAnchor, multiplier: 2),
      labelIndicatorReleaseDate.trailingAnchor.constraint(greaterThanOrEqualTo: labelReleaseDate.leadingAnchor, constant: 2),
      
      labelReleaseDate.topAnchor.constraint(equalTo: labelIndicatorReleaseDate.topAnchor),
      labelReleaseDate.bottomAnchor.constraint(equalTo: labelIndicatorReleaseDate.bottomAnchor),
      labelReleaseDate.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: labelIndicatorReleaseDate.trailingAnchor, multiplier: 2),
      trailingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: labelReleaseDate.trailingAnchor, multiplier: 2),
      
      divider.topAnchor.constraint(equalTo: labelReleaseDate.bottomAnchor, constant: 2),
      divider.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: ivImage.trailingAnchor, multiplier: 2),
      trailingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: divider.trailingAnchor, multiplier: 2),
      divider.heightAnchor.constraint(equalToConstant: 1),
      
      labelIndicatorRating.topAnchor.constraint(equalTo: labelIndicatorReleaseDate.bottomAnchor, constant: 4),
      labelIndicatorRating.bottomAnchor.constraint(lessThanOrEqualTo: ivImage.bottomAnchor),
      labelIndicatorRating.leadingAnchor.constraint(equalToSystemSpacingAfter: ivImage.trailingAnchor, multiplier: 2),
      labelIndicatorRating.trailingAnchor.constraint(greaterThanOrEqualTo: labelIndicatorRating.leadingAnchor, constant: 2),
      
      labelRating.topAnchor.constraint(equalTo: labelIndicatorRating.topAnchor),
      labelRating.bottomAnchor.constraint(equalTo: labelIndicatorRating.bottomAnchor),
      labelRating.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: labelIndicatorRating.trailingAnchor, multiplier: 2),
      trailingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: labelRating.trailingAnchor, multiplier: 2)
    ])
  }
  
  func addToSubView(items views: UIView...) {
    for view in views {
      contentView.addSubview(view)
    }
  }
  
  func setDefautValue() {
    labelIndicatorReleaseDate.text = "Release Date:"
    labelIndicatorRating.text = "Rating:"
    
    ivFavorite.image = UIImage(systemName: "heart.fill")?
      .resize(Size: CGSize(width: (favSize / 2) + 4, height: favSize / 2))?
      .withTintColor(UIColor.red)
  }
}
