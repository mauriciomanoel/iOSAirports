
import UIKit

@IBDesignable
public class ItemWithLabelAndTextField: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var valueTextField: CustomSearchTextField!
    
    private var hintPeriod:String = "Year"
    private var lastValueTextField = ""
    private var currentValueTextField = ""
    private var showHint = true
    
    public var listenerClosure     : ((String)->())?

    private var listenerValue: String = String() {
        didSet {
            self.listenerClosure?(listenerValue)
        }
    }
    
    override init(frame aFrame: CGRect) {
        super.init(frame: aFrame)
        commomInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
    private func commomInit() {
        let bundle = Bundle(identifier: BUNDLE_IDENTIFIER)
        let nib = UINib(nibName: "ItemWithLabelAndTextField", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
        
    }
    
    public func setTitle(_ title: String?) {
        if let _title = title {
            self.title.text = _title
        }
    }
    
    public func setPlaceHolder(_ placeHolder: String?) {
        if let _placeHolder = placeHolder {
            valueTextField.placeholder = _placeHolder
        }
    }
    
}
