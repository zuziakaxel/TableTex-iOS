import UIKit


class Cell: UIView, UITextFieldDelegate {
    
    var txtField: UITextField!
    
    override func drawRect(dirtyRect: CGRect) {
        super.drawRect(dirtyRect)
        
        let str = txtField.text
        txtField = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        txtField.text = str
        
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        var bgColor = UIColor.blackColor()

        
        txtField = UITextField(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))

        txtField.backgroundColor = UIColor.whiteColor()
        txtField.layer.borderColor = UIColor.blackColor().CGColor
        txtField.font = UIFont(name: "Baskerville" , size: 14)
        txtField.textAlignment = NSTextAlignment.Center
        
        self.addSubview(txtField)

        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1.0
       
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDelegate(vc: ViewController){
        
        self.txtField.delegate = vc
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        self.resignFirstResponder()
        return false
    }
}
