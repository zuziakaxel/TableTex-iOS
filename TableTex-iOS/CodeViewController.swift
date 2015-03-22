

import UIKit


class CodeViewController: UIViewController {
    
    @IBOutlet weak var txtInfo: UITextView!
    
    @IBOutlet var btnHam: UIButton!
    var blurView: UIView!
    
    
    @IBAction func onBurger() {
        (tabBarController as TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtInfo.backgroundColor = UIColor.clearColor()
        txtInfo.textColor = UIColor.whiteColor()
        blurView = UIView(frame: self.view.frame)
        
        addBlurToView(blurView)
        self.view.insertSubview(blurView, belowSubview: btnHam)
        colorSyntax()
        
    }
    
    func colorSyntax(){
        let font:UIFont? = UIFont(name: "Baskerville", size: 18.0)
        
        let attrString = NSAttributedString(
            string: txtInfo.text,
            attributes: NSDictionary(
                object: font!,
                forKey: NSFontAttributeName))
        
        

        var words: [String] = self.txtInfo.text.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: " \t\n"))
        var str = NSAttributedString()
        var outputStr = NSMutableAttributedString(attributedString: NSAttributedString(string: ""))
        for word in words{
            
            if word == "\\\\" {
                if let font = UIFont(name: "Baskerville", size: 20.0) {
                    let timeFont = [NSFontAttributeName:font, NSForegroundColorAttributeName: UIColor.yellowColor()]
                    str = NSAttributedString(string: (word+"\t"), attributes : timeFont)
                }
            } else if word == "\\hline" {
                if let font = UIFont(name: "Baskerville", size: 20.0) {
                    let timeFont = [NSFontAttributeName:font, NSForegroundColorAttributeName: UIColor.yellowColor()]
                    str = NSAttributedString(string: word+"\n", attributes : timeFont)
                }
            
            } else if word == "&" {
                if let font = UIFont(name: "Baskerville", size: 20.0) {
                    let timeFont = [NSFontAttributeName:font, NSForegroundColorAttributeName: UIColor.blueColor()]
                    str = NSAttributedString(string: word+"\t", attributes : timeFont)
                }
            } else {
                if let font = UIFont(name: "Baskerville", size: 20.0) {
                    let timeFont = [NSFontAttributeName:font, NSForegroundColorAttributeName: UIColor.whiteColor()]
                    str = NSAttributedString(string: word+"\t", attributes : timeFont)
                }
            }
            outputStr.appendAttributedString(str)
        }

        self.txtInfo.attributedText = outputStr

    }
}