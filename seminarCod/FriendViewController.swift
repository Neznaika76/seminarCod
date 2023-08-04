//
//  FriendViewController.swift
//  seminarCod
//
//  Created by Pavel iPro on 24.07.2023.
//


import UIKit
final class FriendViewController: UITableViewController {
    
    private let networkService = NetworkService()
    private var models: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        models = fileCache.FetchFriends()
        tableView.reloadData()
        title = "Friends"
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        navigetionItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"),style: .plain, target: salf, action: #selector(tap))
        tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
        refreshControl = UIRefreshControl()
        regrechControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        //networkService.getFriends{ [weak self] friends in
        //    self?.models = friends
        //    DispatchQueue.main.async {
        //        self?.tableView.reloadData()
        //    }
        getFriends()
    }
    
    override func vievWillAppeer(_ animated: Bool) {
        super.vievWillAppeer(animated)
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FrendCall", for: indexPath) as? FriendCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.updateCell(model: model)
        return cell
    }
    
    func getFriends() {
        networkService.getFriends{ [weak self] friends in
            switch result {
            case .success(let friends):
                self?.models = friends
                self?.fileCache.addFriends(friends: friends)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.models = self?.fileCache.fetchFriends() ?? []
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
        }
    }
    
}

private extension FriendViewController {
    @objc func tap() {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.type = .moveIn
        animation.duration = 3
        navigationController?.view.layer.add(animation, forKey: nil)
        navigationController?.pushViewController(ProfileViewController(isUsrtProfile: true), animated: false)
    }
    
    @objc func ubdate() {
        networkService.getFriends{ [weak self] friends in
            switch result {
            case .success(let friends):
                self?.models = friends
                self?.fileCache.addFriends(friends: friends)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.models = self?.fileCache.fetchFriends() ?? []
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
        }
    }
    
}
