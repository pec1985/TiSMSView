# Ti.SMSView.View

## Description

Displays an SMS-like view with the text area, scrollable view, and the message "balloons"

## Requirements

- Minimun Ti SDK is 1.7.2
- Move the smsview.bundle found in the "example" folder and put it your Resources dir

## Methods

### sendMessage( string or blob )

displays a message on the right side of the scrollView
### recieveMessage( string or blob )

displays a message on the left side of the scrollView

### loadMessages( array )

Loads messages from an array

Ex:
```
loadMessages(
		[
			{send:'Hello'},
			{recieve:'World'}
		]
	);
```

### addLabel( string )
Inserts a label in the screen

Ex:
```
addLabel( 'Jan 25, 2012' );
```

### blur()

blurs the text area and brings the keyboard down

### focus()

focuses the text area and brings the keyboard up

### empty()

empties the view, clears all messages

## Properties

### assets

String

Folder where the "smsview.bundle" lives relative to the Resources directory. If nothing specified, then it must to places in the Resources itself.

NOTE: Feel free to modify the contents of the smsview.bundle (it's a folder)

### backgroundImage
String or blob

Backround image of the scroll view

### backgroundColor
String

Backround color of the scroll view

### sendColor
String

Color of the "send" message balloon, these are the options:

- 'Blue'
- 'Purple'
- 'Green' -- Default
- 'Gray'
- 'White'

### recieveColor

String

Color of the "recieve" message balloon, these are the options:

- 'Blue'
- 'Purple'
- 'Green'
- 'Gray'
- 'White' -- Default

### selectedColor

String

Color of the "recieve" message balloon, these are the options:

- 'Blue' -- Default
- 'Purple'
- 'Green'
- 'Gray'
- 'White'

### buttonTitle

String

Title of the "send" button

### font

Dictionary

Font of the text area, normal Ti font

### textColor

String

Color of the text in the text area

### textAlignment

String

Alignment of the text in the text area

### autocorrect

Boolean

Autocorrect of the text in the text area

### editable

Boolean

Kinda useless, it makes the text area non writable :)

### returnType

Constant

Return button of keyboard

- Ti.SMSView.RETURNKEY_DEFAULT
- Ti.SMSView.RETURNKEY_GO
- Ti.SMSView.RETURNKEY_GOOGLE
- Ti.SMSView.RETURNKEY_JOIN
- Ti.SMSView.RETURNKEY_NEXT
- Ti.SMSView.RETURNKEY_ROUTE
- Ti.SMSView.RETURNKEY_SEARCH
- Ti.SMSView.RETURNKEY_SEND
- Ti.SMSView.RETURNKEY_YAHOO
- Ti.SMSView.RETURNKEY_DONE
- Ti.SMSView.RETURNKEY_EMERGENCY_CALL


### hasTab

Boolean

Whether the window where the SMSView is has a bottom tab or not

## Events

### click

Fires when the scroll view is clicked. Returns the "image", "view", "text" or "scrollView" property where clicked.

### messageClicked

Identical as above.

### buttonClicked

Fires when the "send" button is clicked

### change

Fires when the value of the text area changed

### camButtonClicked

Fires when a the camera button has been clicked.