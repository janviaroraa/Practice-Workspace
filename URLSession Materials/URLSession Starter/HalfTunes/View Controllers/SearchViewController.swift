import AVFoundation
import AVKit
import UIKit

//
// MARK: - Search View Controller
//
class SearchViewController: UIViewController {
  //
  // MARK: - Constants
  //
  
  /// Get local file path: download task stores tune here; AV player plays it.
  let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  
  let downloadService = DownloadService()
  let queryService = QueryService()
  
  //
  // MARK: - IBOutlets
  //
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  //
  // MARK: - Variables And Properties
  //
  // TODO 6
  
  var searchResults: [Track] = []
  
  lazy var tapRecognizer: UITapGestureRecognizer = {
    var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
    return recognizer
  }()
  
  //
  // MARK: - Internal Methods
  //
  @objc func dismissKeyboard() {
    searchBar.resignFirstResponder()
  }
  
  func localFilePath(for url: URL) -> URL {
    return documentsPath.appendingPathComponent(url.lastPathComponent)
  }
  
  func playDownload(_ track: Track) {
    let playerViewController = AVPlayerViewController()
    present(playerViewController, animated: true, completion: nil)
    
    let url = localFilePath(for: track.previewURL)
    let player = AVPlayer(url: url)
    playerViewController.player = player
    player.play()
  }
  
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
  
  func reload(_ row: Int) {
    tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
  }
  
  //
  // MARK: - View Controller
  //
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    
    // TODO 7
  }
  
}

//
// MARK: - Search Bar Delegate
//
extension SearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    dismissKeyboard()
    
    guard let searchText = searchBar.text, !searchText.isEmpty else {
      return
    }
    
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    queryService.getSearchResults(searchTerm: searchText) { [weak self] results, errorMessage in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      
      if let results = results {
        self?.searchResults = results
        self?.tableView.reloadData()
        self?.tableView.setContentOffset(CGPoint.zero, animated: false)
      }
      
      if !errorMessage.isEmpty {
        print("Search error: " + errorMessage)
      }
    }
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    view.addGestureRecognizer(tapRecognizer)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    view.removeGestureRecognizer(tapRecognizer)
  }
}

//
// MARK: - Table View Data Source
//
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: TrackCell = tableView.dequeueReusableCell(withIdentifier: TrackCell.identifier,
                                                        for: indexPath) as! TrackCell
    // Delegate cell button tap events to this view controller.
    cell.delegate = self
    
    let track = searchResults[indexPath.row]
    // TODO 13
    cell.configure(track: track, downloaded: track.downloaded)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }
}

//
// MARK: - Table View Delegate
//
extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //When user taps cell, play the local file, if it's downloaded.
    
    let track = searchResults[indexPath.row]
    
    if track.downloaded {
      playDownload(track)
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 62.0
  }
}

//
// MARK: - Track Cell Delegate
//
extension SearchViewController: TrackCellDelegate {
  func cancelTapped(_ cell: TrackCell) {
    if let indexPath = tableView.indexPath(for: cell) {
      let track = searchResults[indexPath.row]
      downloadService.cancelDownload(track)
      reload(indexPath.row)
    }
  }
  
  func downloadTapped(_ cell: TrackCell) {
    if let indexPath = tableView.indexPath(for: cell) {
      let track = searchResults[indexPath.row]
      downloadService.startDownload(track)
      reload(indexPath.row)
    }
  }
  
  func pauseTapped(_ cell: TrackCell) {
    if let indexPath = tableView.indexPath(for: cell) {
      let track = searchResults[indexPath.row]
      downloadService.pauseDownload(track)
      reload(indexPath.row)
    }
  }
  
  func resumeTapped(_ cell: TrackCell) {
    if let indexPath = tableView.indexPath(for: cell) {
      let track = searchResults[indexPath.row]
      downloadService.resumeDownload(track)
      reload(indexPath.row)
    }
  }
}

// TODO 19

// TODO 5
