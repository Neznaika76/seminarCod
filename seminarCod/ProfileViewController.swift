//
//  ProfileViewController.swift
//  seminarCod
//
//  Created by Pavel iPro on 04.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var networkService = NetworkService()
    private var profileImageView = UIImageView()
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.textColor = Theme.currentTheme.textColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private var themeView = ThemeView()
    private var isUserProfile: Bool
    
    init(name: String? = nil, photo: UIImage? = nil, isUsrtProfile: Bool) {
        self.isUserProfile = isUserProfile
        super.init(nibName: nil, bundle: nil)
        nameLabel.text = name
        profileImageView.image = photo
        themeView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.currintTheme.backgrorundColor
        setupViews()
        networkService.getFriends{ [weak self] friends in
            self?.updateData(model: user)
        }
    }
    
    func updsteData(model: User?) {
        if let url = URL(string: model.photo ?? ""), let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(data: data)
                }
            }
        }
        DispatchQueue.main.async {
            self.nameLabel.text = (model.firstName ?? "") + " " + (model.oastName ?? "")
        }
    }
   
    private func setupViews() {
        view.addSrbview(profileImageView)
        view.addSudview(nameLabel)
        view.addSubview(themeView)
        setupConstraints()
    }

private func setupConstraints() {
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    themeView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, conxtant: -50),
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30),
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        nameLabel.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
    ])

}
