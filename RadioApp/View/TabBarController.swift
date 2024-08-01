//
//  TabBarViewController.swift
//  RadioApp
//
//  Created by Sergey Zakurakin on 29/07/2024.
//

import UIKit
import SnapKit

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


final class TabBarController: UITabBarController {
    
    // MARK: - UI
    private lazy var customTabBarBackground: UIView = {
        let element = UIView()
        element.backgroundColor = .clear
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - Private Property
    private var customTabBarItemViews = [CustomTabBarItemView]()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isHidden = true
        setupTabs()
        setupCustomTabBar()
        updateTabBarItem(selectedIndex: 0)
        setupConstraints()
         
        
    }
    
    
    //MARK: - Private Methods
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
        view.addSubview(customTabBarBackground)
        
        guard let tabBarItems = tabBar.items else { return }
        
        for index in 0..<tabBarItems.count {
            let tabBarItemView = CustomTabBarItemView(title: tabBarItems[index].title ?? "", image: tabBarItems[index].image)
            
            customTabBarBackground.addSubview(tabBarItemView)
            
            tabBarItemView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(view.frame.width / CGFloat(tabBarItems.count))
                switch index {
                case 0:
                    make.leading.equalToSuperview()
                case 1:
                    make.centerX.equalToSuperview()
                case 2:
                    make.trailing.equalToSuperview()
                default:
                    break
                }
            }
            
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
    
    // MARK: - Constraints Setup
    private func setupConstraints() {
        customTabBarBackground.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}
