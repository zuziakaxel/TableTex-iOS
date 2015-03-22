
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var sidebar: FrostedSidebar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.hidden = true
        
        sidebar = FrostedSidebar(itemImages: [
            UIImage(named: "pen")!,
            UIImage(named: "globe")!,
            UIImage(named: "info")!,
            UIImage(named: "star")!],
            colors: [
                UIColor(red: 226/255, green: 123/255, blue: 41/255, alpha: 1),
                UIColor(red: 226/255, green: 123/255, blue: 41/255, alpha: 1),
                UIColor(red: 226/255, green: 123/255, blue: 41/255, alpha: 1),
                UIColor(red: 226/255, green: 123/255, blue: 41/255, alpha: 1)],
            selectedItemIndices: NSIndexSet(index: 0))
        
        sidebar.isSingleSelect = true
        sidebar.actionForIndex = [
            0: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 0}) },
            1: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 1}) },
            2: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 2}) },
            3: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 3}) }]
    }
    
}
