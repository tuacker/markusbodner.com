+++
date = "2017-06-20T13:48:09+02:00"
draft = false
tags = ["Swift", "Budget With Claire", "Devlog"]
title = "How to verify and limit decimal number inputs in iOS with Swift"

+++

In [Budget With Claire](https://budgetwithclaire.com), an app to manage your personal budget, I need a way for users to enter monetary values. Apple only provides UITextField for inputs which always returns a string. You can define a keyboard layout (decimal pad in my case) but that is where support for numeric inputs in iOS ends.

Today I'm going to show you how to limit the characters a user can enter and verify we actually have a number. (_Hint:_ Don't trust the chosen keyboard layout! The user can copy/paste). With the decimal pad keyboard the user can enter strings like `32,241,241,1,1` or `23.13.1.` neither of which are legit numbers, let alone monetary.

I'll show you how to create a text input which only allows valid decimal numbers and limits the amount of decimal places. With locale specific variations in mind: `5.5` in the US is equal to `5,5` in Germany for example, and our app should support both.

I assume you already have a UITextField in your storyboard. Make sure you have the keyboard type set to `Decimal Pad` either in the storyboard or in code and connected the outlet to your ViewController. The first thing we have to do now is declare our ViewController as textfield delegate:

```swift
// ViewController.swift
// Make sure our ViewController is a UITextFieldDelegate
class ViewController: UIViewController, UITextFieldDelegate {
  @IBOutlet var moneyTextField: UITextField!

  override func viewDidLoad() {
    // Declare ourself as textfield delegate
    moneyTextField.delegate = self
  }
}
```

Here we add the `UITextFieldDelegate` protocol to our class and set the `moneyTextField.delegate` to the `viewController (self)`.

Now to the actual validation by implementing the `textField(shouldChangeCharactersIn:)` method. This method runs every time the user modifies the text in any way (typing, deleting, pasting) and before the UI reflects the changes.

```swift
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
  // User pressed the delete-key to remove a character, this is always valid, return true to allow change
  if string.isEmpty { return true }

  // Build the full current string: TextField right now only contains the
  // previous valid value. Use provided info to build up the new version.
  // Can't just concat the two strings because the user might've moved the
  // cursor and delete something in the middle.
  let currentText = textField.text ?? ""
  let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)

  // Use our string extensions to check if the string is a valid double and
  // only has the specified amount of decimal places.
  return replacementText.isValidDouble(maxDecimalPlaces: 2)
}
```

Here we build what the new string would look like as `replacementText` and then use my own `String` extension `isValidDouble(maximalDecimalPlaces:)` to verify the input. I'm using an extension because I have many places where I need to perform this check. If you only accept number inputs in this place and nowhere else feel free to move the code into the method above.

Quick explanation for `shouldChangeCharactersIn:`: If you return true then iOS updates the textField value with the changes the user performed. But if you return false the changes get dropped and nothing happens.

Here is the extension implementation performing the actual checks:

```swift
extension String {
  func isValidDouble(maxDecimalPlaces: Int) -> Bool {
    // Use NumberFormatter to check if we can turn the string into a number
    // and to get the locale specific decimal separator.
    let formatter = NumberFormatter()
    formatter.allowsFloats = true // Default is true, be explicit anyways
    let decimalSeparator = formatter.decimalSeparator ?? "."  // Gets the locale specific decimal separator. If for some reason there is none we assume "." is used as separator.

    // Check if we can create a valid number. (The formatter creates a NSNumber, but
    // every NSNumber is a valid double, so we're good!)
    if formatter.number(from: self) != nil {
      // Split our string at the decimal separator
      let split = self.components(separatedBy: decimalSeparator)

      // Depending on whether there was a decimalSeparator we may have one
      // or two parts now. If it is two then the second part is the one after
      // the separator, aka the digits we care about.
      // If there was no separator then the user hasn't entered a decimal
      // number yet and we treat the string as empty, succeeding the check
      let digits = split.count == 2 ? split.last ?? "" : ""

      // Finally check if we're <= the allowed digits
      return digits.characters.count <= maxDecimalPlaces    // TODO: Swift 4.0 replace with digits.count, YAY!
    }

    return false // couldn't turn string into a valid number
  }
}
```

First we create a NumberFormatter, a locale aware way to get numbers from Strings and ask it for the decimal separator. We then try to create a number from the string. When that succeeds we check if the number of decimal places is less than or equal to the provided. If everything checks out we return true at which point the UI updates with the modifications to the textField.

Now we have a textField input that only accepts valid numbers, respects locale specific decimal separators and limits the number of decimal places to whatever we want.

The user can never enter a non-valid number, not even by pasting in some garbage and once they're ready to save you can be sure it is valid. (Of course the textField can still be empty!)
