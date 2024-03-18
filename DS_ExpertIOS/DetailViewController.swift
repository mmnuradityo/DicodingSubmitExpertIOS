//
//  DetailViewControler.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//
import UIKit
import SwiftUI
import DSCore
import DSBase

struct DetailViewControllerView: UIViewControllerRepresentable {
  let game: GameModel
  
  func makeUIViewController(context: Context) -> UIViewController {
    let detailView = HomeRouter().makeDetailView(game: game)
    return detailView
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    // update code
  }
}

class DetailViewController: UIViewController {
  let presenter: DetailPresenter
  
  private let imgSize: CGFloat = 180
  private let contentMargin: CGFloat = 24
  
  // container
  let scrollView = UIScrollView()
  let contentSv = UIStackView()
  let imageContainer = UIView()
  // content
  let ivContent = UIImageView()
  let indicatorLoading = UIActivityIndicatorView()
  let componentView = DetailComponentView()
  let lableDesc = UILabel()
  let notificationUtils = NotificationUtils()
  
  init(presenter: DetailPresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    notificationUtils.setup()
    navigationItem.leftBarButtonItem = barBtnBack()
    
    style()
    layout()
    onDataSet()
  }
  
  func onDataSet() {
    navigationItem.title = "Game Detail"
    
    presenter.$game.sink { geme in
      if let game = geme {
        self.setDataGame(game: game)
      } else {
        self.navigationItem.title = "Data tidak ditemukan!"
      }
    }.store(in: &presenter.cancellables)
    
    presenter.$errorMessage.sink { errorMessage in
      if !errorMessage.isEmpty,
         let delegate = UIApplication.shared.delegate as? AppDelegate,
         let window = delegate.window {
        self.displayToast(
          errorMessage, width: UIScreen.main.bounds.size.width - 40, window: window
        )
      }
    }.store(in: &presenter.cancellables)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getGamesDetail()
  }
  
  func startDownloadImage() {
    presenter.startDownloadImage()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension DetailViewController {
  func style() {
    view.backgroundColor = .systemBackground
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    
    contentSv.translatesAutoresizingMaskIntoConstraints = false
    contentSv.axis = .vertical
    contentSv.alignment = .fill
    contentSv.distribution = .fill
    contentSv.spacing = 18
    
    imageContainer.translatesAutoresizingMaskIntoConstraints = false
    
    ivContent.translatesAutoresizingMaskIntoConstraints = false
    ivContent.contentMode = .scaleAspectFill
    ivContent.layer.masksToBounds = false
    ivContent.clipsToBounds = true
    
    indicatorLoading.translatesAutoresizingMaskIntoConstraints = false
    
    lableDesc.translatesAutoresizingMaskIntoConstraints = false
    lableDesc.font = UIFont.preferredFont(forTextStyle: .caption1)
    lableDesc.textAlignment = .justified
    lableDesc.numberOfLines = 0
    
    componentView.btnFavorite.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
  }
  
  func layout() {
    imageContainer.addSubview(ivContent)
    imageContainer.addSubview(indicatorLoading)
    
    addToScroll(items: imageContainer, componentView, lableDesc)
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
      
      contentSv.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
      contentSv.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
      contentSv.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
      contentSv.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0),
      contentSv.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0),
      
      imageContainer.leadingAnchor.constraint(equalTo: contentSv.leadingAnchor, constant: -contentMargin),
      imageContainer.heightAnchor.constraint(equalToConstant: imgSize),
      
      ivContent.topAnchor.constraint(equalTo: imageContainer.topAnchor),
      ivContent.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
      ivContent.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
      imageContainer.trailingAnchor.constraint(equalTo: ivContent.trailingAnchor),
      
      indicatorLoading.topAnchor.constraint(equalTo: imageContainer.topAnchor),
      indicatorLoading.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
      indicatorLoading.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
      imageContainer.trailingAnchor.constraint(equalTo: indicatorLoading.trailingAnchor),
      
      componentView.leadingAnchor.constraint(equalTo: contentSv.leadingAnchor, constant: contentMargin),
      contentSv.trailingAnchor.constraint(equalTo: componentView.trailingAnchor, constant: contentMargin),
      
      lableDesc.leadingAnchor.constraint(equalTo: contentSv.leadingAnchor, constant: contentMargin),
      contentSv.trailingAnchor.constraint(equalTo: lableDesc.trailingAnchor, constant: contentMargin)
    ])
  }
  
  func addToScroll(items views: UIView...) {
    for view in views {
      contentSv.addArrangedSubview(view)
    }
    
    scrollView.addSubview(contentSv)
    addToSubView(items: scrollView)
  }
  
  private func setDataGame(game: GameModel) {
    componentView.labelTitle.text = game.title
    componentView.labelReleaseDate.text = "Release Date: \(DateUtils.getDateString(date: game.releaseDate))"
    componentView.labelRating.text = "Rating: \(game.rating.description)"
    componentView.labelGenre.text = "Genre: \(game.genre)"
    componentView.labelReview.text = "Total Review: \(game.reviewsCount.description)"
    
    let attributeDesc = game.description.convertHtml()
    attributeDesc.replaceFont(with: lableDesc.font)
    lableDesc.attributedText = attributeDesc
    
    ivContent.image = game.image != nil ? UIImage(data: game.image!) : nil
    
    if game.state == .new {
      indicatorLoading.isHidden = false
      indicatorLoading.startAnimating()
      
      startDownloadImage()
    } else {
      indicatorLoading.isHidden = true
      indicatorLoading.stopAnimating()
    }
    
    setBtnImage(isFavorite: game.isFavorite)
  }
  
}

extension DetailViewController {
  @objc func handleFavorite(sender: UIButton) {
    self.notificationUtils.requestNotif {
      DispatchQueue.main.sync {
        self.presenter.updateFavorite { game in
          self.notify(
            game, message: game.isFavorite ? "Save to favorite" : "Remove from favorite"
          )
        }
      }
    }
  }
  
  func setBtnImage(isFavorite: Bool) {
    let heartImg = UIImage(systemName: isFavorite ? "heart.fill" : "heart")?
      .resize(Size: CGSize(width: 36, height: 32))?
      .withTintColor(UIColor.red)
    
    componentView.btnFavorite.setImage(heartImg, for: .normal)
  }
  
  func notify(_ game: GameModel, message: String) {
    DispatchQueue.main.async {
      let content = UNMutableNotificationContent()
      content.title = game.title
      content.body = message
      content.sound = .default
      
      self.notificationUtils.notify(content: content)
    }
  }
}
