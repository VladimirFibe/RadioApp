import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}

class PopularViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
    }
}

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    private var customTabBarItemViews = [CustomTabBarItemView]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        
        // Скрываем стандартный таббар
        tabBar.isHidden = true
        
        // Настройка пользовательского таббара
        setupCustomTabBar()
        
        self.delegate = self
        updateTabBarItem(selectedIndex: 0)
    }
    
    private func setupTabs() {
        let popularVC = PopularViewController()
        popularVC.tabBarItem = UITabBarItem(title: "Popular", image: UIImage(named: "ellipse"), tag: 0)
        
        let favoriteVC = ViewController()
        favoriteVC.view.backgroundColor = .green
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "ellipse"), tag: 1)
        
        let allStationVC = ViewController()
        allStationVC.view.backgroundColor = .blue
        allStationVC.tabBarItem = UITabBarItem(title: "AllStation", image: UIImage(named: "ellipse"), tag: 2)
        
        viewControllers = [popularVC, favoriteVC, allStationVC]
    }
    
    private func setupCustomTabBar() {
        let customTabBarBackground = UIView()
        customTabBarBackground.backgroundColor = .clear
        customTabBarBackground.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(customTabBarBackground)
        
        NSLayoutConstraint.activate([
            customTabBarBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBarBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBarBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customTabBarBackground.heightAnchor.constraint(equalToConstant: 80) // Высота кастомного таббара
        ])
        
        // Проверка наличия viewControllers и tabBar.items
        guard let viewControllers = viewControllers, let tabBarItems = tabBar.items else {
            print("Error: viewControllers or tabBar.items is nil.")
            return
        }
        
        for (index, _) in viewControllers.enumerated() {
            let tabBarItemView = CustomTabBarItemView(title: tabBarItems[index].title ?? "",
                                                      image: tabBarItems[index].image ?? UIImage())
            
            tabBarItemView.translatesAutoresizingMaskIntoConstraints = false
            customTabBarBackground.addSubview(tabBarItemView)
            
            NSLayoutConstraint.activate([
                tabBarItemView.leadingAnchor.constraint(equalTo: customTabBarBackground.leadingAnchor, constant: CGFloat(index) * (view.frame.width / CGFloat(viewControllers.count))),
                tabBarItemView.widthAnchor.constraint(equalToConstant: view.frame.width / CGFloat(viewControllers.count)),
                tabBarItemView.topAnchor.constraint(equalTo: customTabBarBackground.topAnchor),
                tabBarItemView.bottomAnchor.constraint(equalTo: customTabBarBackground.bottomAnchor)
            ])
            
            tabBarItemView.tag = index
            tabBarItemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabBarItemTapped(_:))))
            
            customTabBarItemViews.append(tabBarItemView)
        }
    }
    
    @objc private func tabBarItemTapped(_ sender: UITapGestureRecognizer) {
        if let index = sender.view?.tag {
            selectedIndex = index
            updateTabBarItem(selectedIndex: index)
        }
    }
    
    private func updateTabBarItem(selectedIndex: Int) {
        for (index, tabBarItemView) in customTabBarItemViews.enumerated() {
            if index == selectedIndex {
                tabBarItemView.titleLabel.textColor = .white
                tabBarItemView.setActive(true)
            } else {
                tabBarItemView.titleLabel.textColor = .gray
                tabBarItemView.setActive(false)
            }
        }
    }
}
