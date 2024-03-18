//
//  ViewController.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//
import UIKit
import DSCore
import DSBase
import DSSearch

class HomeViewController: UIViewController {
  private let presenter: HomePresenter
  private let searchViewBar: SearchViewBar
  
  private let progressContainer = UIStackView()
  private let progress = UIActivityIndicatorView()
  private let progressLabel = UILabel()
  
  private let tableGames = UITableView()
  private var list: [GameModel] = []
  
  init(presenter: HomePresenter, searchViewBar: SearchViewBar) {
    self.presenter = presenter
    self.searchViewBar = searchViewBar
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
    onDataSet()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if searchViewBar.isSearchActivated {
      searchViewBar.loadSearch()
    } else {
      presenter.getAllGames()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeViewController {
  func style() {
    searchViewBar.setStyle()
    searchViewBar.delegate = self
    
    tableGames.translatesAutoresizingMaskIntoConstraints = false
    tableGames.dataSource = self
    tableGames.delegate = self
    
    progressContainer.translatesAutoresizingMaskIntoConstraints = false
    progressContainer.axis = .vertical
    progressContainer.alignment = .center
    progressContainer.distribution = .fill
    progressContainer.spacing = 10
    
    progress.translatesAutoresizingMaskIntoConstraints = false
    
    progressLabel.translatesAutoresizingMaskIntoConstraints = false
    progressLabel.textColor = .lightGray
    progressLabel.text = "Loading data..."
  }
  
  func layout() {
    tableGames.register(
      HomeGameTableViewCell.self, forCellReuseIdentifier: HomeGameTableViewCell.cellIdentifier
    )
    tableGames.rowHeight = HomeGameTableViewCell.rowHight
    
    addToSubView(items: tableGames)
    addToSubView(progressContainer, items: progress, progressLabel)
    
    NSLayoutConstraint.activate([
      tableGames.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableGames.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableGames.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tableGames.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      progressContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      progressContainer.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
    ])
  }
  
}

extension HomeViewController {
  
  private func onDataSet() {
    searchViewBar.showOrHideSearchBar(isShow: false)
    navigationItem.rightBarButtonItem = searchViewBar.searchButton
    
    presenter.$games.sink { games in
      self.setList(games: games)
    }.store(in: &presenter.cancellables)
    
    presenter.$loadingState.sink { isLoading in
      self.setLoading(isLoading: isLoading)
    }.store(in: &presenter.cancellables)
    
    presenter.$errorMessage.sink { errorMessage in
      self.setError(errorMessage: errorMessage)
    }.store(in: &presenter.cancellables)
    
    searchViewBar.observeSearch { (games, isLoading, errorMessage) in
      if games != nil {
        self.setList(games: games!)
      } else if errorMessage != nil {
        self.setError(errorMessage: errorMessage!)
      } else if isLoading != nil {
        self.setLoading(isLoading: isLoading!)
      }
    }
  }
  
  private func startDownload(game: GameModel, indexPath: IndexPath) {
    presenter.startDownloadImage(game: game) {
      self.tableGames.reloadRows(at: [indexPath], with: .automatic)
    }
  }
  
  private func setList(games: [GameModel]) {
    if games.count > 0 {
      self.list = games
      self.tableGames.reloadData()
    }
  }
  
  private func setLoading(isLoading: Bool) {
    self.tableGames.isHidden = isLoading
    self.progressContainer.isHidden = !isLoading
    
    if isLoading {
      self.progress.startAnimating()
    } else {
      self.progress.stopAnimating()
    }
  }
  
  private func setError(errorMessage: String) {
    if !errorMessage.isEmpty {
      displayToast(
        errorMessage, width: UIScreen.main.bounds.size.width - 40
      )
    }
  }
}

extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return list.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(
      withIdentifier: HomeGameTableViewCell.cellIdentifier,
      for: indexPath
    ) as? HomeGameTableViewCell {
      let game = list[indexPath.row]
      cell.labelName.text = game.title
      cell.labelReleaseDate.text = DateUtils.getDateString(date: game.releaseDate)
      cell.labelRating.text = game.rating.description
      
      cell.ivImage.image = game.image != nil ? UIImage(data: game.image!) : nil
      cell.ivFavorite.isHidden = !game.isFavorite
      
      if game.state == .new {
        cell.indicatorLoading.isHidden = false
        cell.indicatorLoading.startAnimating()
        startDownload(game: game, indexPath: indexPath)
        
      } else {
        cell.indicatorLoading.stopAnimating()
        cell.indicatorLoading.isHidden = true
      }
      return cell
    }
    
    return UITableViewCell()
  }
}

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailView = presenter.homeRouter.makeDetailView(game: list[indexPath.row])
    present(detailView, animated: true)
  }
}

extension HomeViewController: SearchViewBarDelegate {
  func onHideSearchBar() {
    navigationItem.title = "List Games"
    navigationItem.titleView = nil
    navigationItem.rightBarButtonItem = searchViewBar.searchButton
    
    presenter.clearGames()
    presenter.getAllGames()
  }
  
  func onShowSearchBar() {
    navigationItem.title = ""
    navigationItem.titleView = searchViewBar.searchBar
    navigationItem.rightBarButtonItem = searchViewBar.cancelSearchButton
  }
  
}
