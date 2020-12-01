# SJDatePicker
DatePicker for swift 5, using **UIPresentationController** and **UIViewControllerAnimatedTransitioning**.


## Example
Just run the example project, or clone the repo.


## Requirements
* Xcode 12 or above
* iOS 14
* Swift 5.2
* Support Dark mode

![GITHUB](https://github.com/SabrinaJiang14/SJDatePicker/blob/master/Example/demo.gif "demo")


## Basic Usage
- Example code
``` swift
let pick:PresentedViewController = PresentedViewController()
pick.style = DefaultStyle()
pick.block = { [weak self] (date) in
    self?.txtShowDate.text = date
}
self.present(pick, animated: true, completion: nil)
```

## Customize property

You can use default style to setup the picker ui color, or set property in default style
``` swift
var style = DefaultStyle()
// You can set one or mutilple colors in picker text color
style.pickerColor = StyleColor.colors([style.textColor, .red, .blue]) // or StyleColor.color(UIColor.red)
// Picker mode
style.pickerMode = .date
// If you want a title in datePicker, you can use this.
style.titleString = "This is Date Picker"
// Define some date format
style.returnDateFormat = .d_m_yyyy
// The minimum date
style.minimumDate = Date()
// The maximum date
style.maximumDate = Date().addingTimeInterval(3600*24*7*52)
// Set title font
style.titleFont = UIFont.systemFont(ofSize: 25, weight: .bold)
```
In addition, you also can custom style by implement ```PickerStyle```, like as:
``` swift 
struct CustomStyle:PickerStyle {
    var textColor:UIColor
    var pickerColor: StyleColor?
    var timeZone: TimeZone?
    var minimumDate: Date?
    var maximumDate: Date?
    var pickerMode:UIDatePicker.Mode?
    var titleFont:UIFont?
    var returnDateFormat:DateFormat?
    var titleString: String?
}
```




---
# Licence
Licence MIT
