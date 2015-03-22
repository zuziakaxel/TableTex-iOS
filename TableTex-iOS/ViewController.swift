
import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var toolsBar: UIView!

    
    
    
    @IBOutlet var lblColumns: UILabel!
    @IBOutlet var btnAddColumn: UIButton!
    @IBOutlet var btnRemoveColumn: UIButton!
    @IBOutlet var btnAddRow: UIButton!
    @IBOutlet var btnRemoveRow: UIButton!
    @IBOutlet var lblRows: UILabel!
    
    
    @IBOutlet var btnIncreaseWidth: UIButton!
    @IBOutlet var btnDecreaseWidth: UIButton!
    @IBOutlet var btnIncreaseHeight: UIButton!
    @IBOutlet var btnDecreaseHeight: UIButton!
    
    @IBAction func onBurger() {
        self.resignFirstResponder()
        (tabBarController as TabBarController).sidebar.showInViewController(self, animated: true)
    }

    var contentView: UIView!
    var table: VisibleTable!
    var nbOfColumns:Int = 1
    var nbOfRows:Int = 1
    var width: Int = 100
    var height: Int = 40
    
    
    @IBAction func increaseHeight(sender: AnyObject) {
        height += 10
        resetAll()
        table = VisibleTable(tableHolderView: self.contentView,vc: self, rows: nbOfRows, columns: nbOfColumns, cellWidth: CGFloat(width), cellHeight: CGFloat(height))
        updateContentView()
        table.drawTableOnView(self.contentView)
    }
    @IBAction func decreaseHeight(sender: AnyObject) {
        if height < 10 {
            return
        }
        height -= 10
                resetAll()
        table = VisibleTable(tableHolderView: self.contentView,vc: self, rows: nbOfRows, columns: nbOfColumns, cellWidth: CGFloat(width), cellHeight: CGFloat(height))
        updateContentView()
        table.drawTableOnView(self.contentView)
    }
    @IBAction func increaseWidth(sender: AnyObject) {
        width += 10
                resetAll()
        table = VisibleTable(tableHolderView: self.contentView,vc: self, rows: nbOfRows, columns: nbOfColumns, cellWidth: CGFloat(width), cellHeight: CGFloat(height))
        updateContentView()
        table.drawTableOnView(self.contentView)
    }
    @IBAction func decreaseWidth(sender: AnyObject) {
        if width < 10 {
            return
        }
        width -= 10
                resetAll()
        table = VisibleTable(tableHolderView: self.contentView,vc: self, rows: nbOfRows, columns: nbOfColumns, cellWidth: CGFloat(width), cellHeight: CGFloat(height))
        updateContentView()
        table.drawTableOnView(self.contentView)
    }
    @IBAction func addRow(sender: AnyObject) {

        updateRowsNumber(++nbOfRows)
        lblRows.text = "\(nbOfRows)"
    }
    @IBAction func addColumn(sender: AnyObject) {
        updateColumnsNumber(Int(++nbOfColumns))
        lblColumns.text = "\(nbOfColumns)"
    }
    @IBAction func removeRow(sender: AnyObject) {
        if nbOfRows == 1 {
            return
        }
        updateRowsNumber(Int(--nbOfRows))
        lblRows.text = "\(nbOfRows)"
    }
    @IBAction func removeColumn(sender: AnyObject) {
        if nbOfColumns == 1 {
            return
        }
        updateColumnsNumber(Int(--nbOfColumns))
        lblColumns.text = "\(nbOfColumns)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        
        contentView = UIView(frame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height))

        contentView.layer.backgroundColor = UIColor(red: 226, green: 123, blue: 41, alpha: 0.8).CGColor
//        contentView.layer.borderWidth = 4.0
        contentView.layer.borderColor = UIColor(red: 226, green: 123, blue: 41, alpha: 0.8).CGColor
        
        contentView.drawRect(CGRect(x: contentView.frame.origin.x, y: contentView.frame.origin.x, width: contentView.frame.width, height: contentView.frame.height))
        
        toolsBar.backgroundColor = UIColor(red: 226, green: 123, blue: 41, alpha: 0.8)
        /// Create shadow
        
        var dropShadow = NSShadow()

        contentView.layer.shadowColor = UIColor(red: CGFloat(121/250), green: CGFloat(187/250), blue: CGFloat(248/250), alpha: 1).CGColor
        
        contentView.layer.shadowRadius = 10.0
 
        contentView.layer.shadowOffset = CGSize(width: 5, height: 10)
        table = VisibleTable(tableHolderView: self.contentView,vc: self, rows: nbOfRows, columns: nbOfColumns, cellWidth: CGFloat(width), cellHeight: CGFloat(height))
        updateContentView()
        table.drawTableOnView(self.contentView)

        setupButtons()
        setupScrollView()
        adjustScrollView()
        
        addBlurToView(toolsBar)
        
        
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateColumnsNumber(value: Int) {
        if value < 1 {
            return
        }
//        stepperColumns.value = value
//        txtColumns.text = "\(value)"
        nbOfColumns = Int(value)
        table.updateArray(nbOfColumns, newNumberOfRows: nbOfRows)
        updateContentView()
    }
    
    func updateRowsNumber(value: Int) {
        if value < 1 {
            return
        }
//        stepperRows.value = value
//        txtRows.text = "\(value)"
        nbOfRows = Int(value)
        println("------VC---------\n col-\(nbOfColumns) - row - \(nbOfRows)")
        
        table.updateArray(nbOfColumns, newNumberOfRows: nbOfRows)
        updateContentView()
    }
    
    func updateContentView(){

        contentView.frame.size.height = table.cellHeight * CGFloat(table.rowsCount)
        contentView.frame.size.width = table.cellWidth * CGFloat(table.columnsCount)
        adjustScrollView()
    }
    func resetAll(){
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
    }
    
    
    func centerScrollViewContents() {
        
        let boundsSize = scrollView.bounds.size
        var contentsFrame = contentView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        contentView.frame = contentsFrame
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        
        let pointInView = recognizer.locationInView(contentView)
        
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        scrollView.zoomToRect(rectToZoomTo, animated: true)
    }
    
//    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
//        return contentView
//    }
    
    func scrollViewDidZoom(scrollView: UIScrollView!) {
        centerScrollViewContents()
    }
    
    func adjustScrollView() {
        
        if contentView.frame.height > self.view.frame.height {
            scrollView.contentSize.height = contentView.frame.height
        }
        if contentView.frame.width > self.view.frame.width {
            scrollView.contentSize.width = contentView.frame.width
        }
        let scrollViewFrame = self.view.frame
        scrollView.frame.origin.y += 50
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        
        scrollView.minimumZoomScale = minScale;
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale;
        println("MIN SCALE: \(minScale)")
        centerScrollViewContents()
        
    }
    
    func setupScrollView() {
        scrollView.zoomScale = 1.0
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = true
        var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        scrollView.addSubview(contentView)
        
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        adjustScrollView()
    }

    func setupButtons() {
        var imgPlus = UIImage(named: "plus")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        var imgMinus = UIImage(named: "minus")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        btnAddRow.setImage(imgPlus, forState: UIControlState.Normal)
        btnAddColumn.setImage(imgPlus, forState: UIControlState.Normal)
        btnRemoveRow.setImage(imgMinus, forState: UIControlState.Normal)
        btnRemoveColumn.setImage(imgMinus, forState: UIControlState.Normal)
        btnIncreaseWidth.setImage(imgPlus, forState: UIControlState.Normal)
        btnDecreaseWidth.setImage(imgMinus, forState: UIControlState.Normal)
        btnIncreaseHeight.setImage(imgPlus, forState: UIControlState.Normal)
        btnDecreaseHeight.setImage(imgMinus, forState: UIControlState.Normal)
        btnDecreaseHeight.tintColor = UIColor(red: 226/250, green: 123/250, blue: 41/250, alpha: 1)
        btnIncreaseHeight.tintColor = UIColor(red: 226/250, green: 123/250, blue: 41/250, alpha: 1)
        btnDecreaseWidth.tintColor = UIColor(red: 226/250, green: 123/250, blue: 41/250, alpha: 1)
        btnIncreaseWidth.tintColor = UIColor(red: 226/250, green: 123/250, blue: 41/250, alpha: 1)
        btnAddRow.tintColor = UIColor(red: 226/250, green: 123/250, blue: 41/250, alpha: 1)
        btnAddColumn.tintColor = UIColor(red: 226/250, green: 123/250, blue: 41/250, alpha: 1)
        btnRemoveColumn.tintColor = UIColor(red: 226/250, green: 123/250, blue: 41/250, alpha: 1)
        btnRemoveRow.tintColor = UIColor(red: 226/250, green: 123/250, blue: 41/250, alpha: 1)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        self.resignFirstResponder()
        return false
    }
}

