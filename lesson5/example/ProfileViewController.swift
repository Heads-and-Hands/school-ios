//
//  ProfileViewController.swift
//  example
//
//  Created by basalaev on 04.12.2019.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}

class ProfileViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!

    private var data = CellType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInset.top = imageView.frame.height
        tableView.backgroundColor = .clear
        tableView.dataSource = self

        tableView.tableHeaderView = headerView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        print("viewDidDisappear")
    }

    var childVC: UIViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "childVC" else {
            return
        }

        if let childVC = segue.destination as? ProfileNotAuthViewController {
            childVC.delegate = self
        }
    }
}

extension ProfileViewController {
    enum CellType: CaseIterable {
        case settings
        case delivery
        case about

        var image: UIImage? {
            let name: String

            switch self {
            case .settings:
                name = "Menu/settings"
            case .delivery:
                name = "Menu/delivery"
            case .about:
                name = "Menu/about"
            }

            return UIImage(named: name)
        }

        var title: String {
            switch self {
            case .settings:
                return "Настройки"
            case .delivery:
                return "Доставка"
            case .about:
                return "О приложении"
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCellID") else {
            fatalError()
        }

        if let cell = cell as? MenuCell {
            let cellType = data[indexPath.row]
            cell.titleLabel.text = cellType.title
            cell.iconImageView.image = cellType.image
        }

        return cell
    }
}

extension ProfileViewController: ProfileNotAuthVCDelegate {
    func didSelectAuthButton() {
        performSegue(withIdentifier: "auth", sender: nil)
    }
}
