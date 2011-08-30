# Ti.Pedro.SMSView

## Description

Displays an SMS-like view with the text area, scrollable view, and the message "balloons"

----
## Methods

### sendMessage( string or blob )

displays a message on the right side of the scrollView
### recieveMessage( string or blob )

displays a message on the left side of the scrollView

### loadMessages( array )

Loads messages from an array

Ex: loadMessages(
		[
		
			{send:'Hello'},
			
			{recieve:'World'}
			
		]
	);

### blur()
void

blurs the text area and brings the keyboard down

### focus()

focuses the text area and brings the keyboard up

### empty()

void

empties the view, clears all messages
----
## Properties

### backgroundImage
String or blob

Backround image of the scroll view

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

- Ti.Pedro.RETURNKEY_DEFAULT
- Ti.Pedro.RETURNKEY_GO
- Ti.Pedro.RETURNKEY_GOOGLE
- Ti.Pedro.RETURNKEY_JOIN
- Ti.Pedro.RETURNKEY_NEXT
- Ti.Pedro.RETURNKEY_ROUTE
- Ti.Pedro.RETURNKEY_SEARCH
- Ti.Pedro.RETURNKEY_SEND
- Ti.Pedro.RETURNKEY_YAHOO
- Ti.Pedro.RETURNKEY_DONE
- Ti.Pedro.RETURNKEY_EMERGENCY_CALL

----
## Events

### click

Fires when the scroll view is clicked

### buttonClicked

Fires when the "send" button is clicked

### change

Fires when the value of the text area changed

### messageClicked

Fires when a message has been clicked.

Returns either an image or text

### camButtonClicked

Fires when a the camera button has been clicked.







