# SJDatePicker
DatePicker for swift 3, using **UIPresentationController** and **UIViewControllerAnimatedTransitioning**.


## Example
Just run the example project, or clone the repo.


## Requirements
* Xcode 8 or above
* iOS 10
* Swift 3

![GITHUB](https://github.com/SabrinaJiang14/SJDatePicker/blob/master/Example/demo.gif "demo")


## Basic Usage
- Example code
``` swift
let pick:PresentedViewController = PresentedViewController()
pick.block = { (date) in
   print(date ?? "No Date")
}
self.present(pick, animated: true, completion: nil)
```

## Customize property
``` swift
public var buttonColor: UIColor 
// Change button background color and title string color.
// The default color is blue, if you don't want change any color.
```
``` swift
public var pickerMode: UIDatePickerMode
// The UIDatePicker mode
```
``` swift
public var minimumDate: Date?
// The UIDatePicker minimumDate
```
``` swift
public var maximumDate: Date?
// The UIDatePicker maximumDate
```
``` swift
public var date_format: dateformat
// Define some date format, like:
/* enum dateformat:String{
    case yyyy_m_d = "yyyy/MM/dd"
    case d_m_yyyy = "dd/MM/yyyy"
    case m_d_yy = "MM/dd/yy"
    case d_mmmm_yy = "d-MMMM-yy"
    case d_mmmm = "dd-MMMM"
    case mmmm_yy = "MMMM-yy"
    case h_mm_PM = "hh:mm aaa"
    case h_mm_ss = "HH:mm:ss"
    case yyyy_To_ss = "yyyy/MM/dd HH:mm:ss"
}*/
// You can choose any one, and use it; or add another format.
```
``` swift
public var titleString: String?
// If you want a title in datePicker,
// you can use this.
```





---
# Licence
Licence MIT
