import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
//        self.navigationController?.isNavigationBarHidden = true
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        selectedIndex = 0
        
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .systemGray6
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.systemGray6
        tabBar.standardAppearance = tabBarAppearance
    }

    private func setupTabs() {
        let news = createTab(with: "Popular", image: UIImage(systemName: "newspaper.fill"), vc: MainNewsController())
        let explore = createTab(with: "Search", image: UIImage(systemName: "magnifyingglass"), vc: ExploreController())
        let forUser = createTab(with: "Explore", image: UIImage(systemName: "play.square.stack"), vc: ForUserController())
        let video = createTab(with: "Profile", image: UIImage(systemName: "person.crop.circle"), vc: VideoNewsController())
        
        viewControllers = [news, explore, forUser, video]
    }
    
    private func createTab(with title: String, image: UIImage?, vc: UIViewController) -> UIViewController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
