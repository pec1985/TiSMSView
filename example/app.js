/*
 Copyright 2011 Pedro Enrique
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

Titanium.SMSView = require('ti.smsview');

var buttonBar = Ti.UI.createButtonBar({
	labels:['Recieve','Empty','Get All','Disable','Enable'],
	backgroundColor:'green',
	height:30
});

var headerView = Ti.UI.createView();

headerView.add(buttonBar);

var win = Ti.UI.createWindow({
	titleControl:buttonBar,
	orientationModes:[1,2,3,4]
});

var textArea = Ti.SMSView.createView({
	//maxLines:6,				// <--- Defaults to 4
	//minLines:2,				// <--- Defaults to 1
	backgroundColor: '#dae1eb',	// <--- Defaults to #dae1eb
	assets: 'assets',			// <--- Defauls to nothing, smsview.bundle can be places in the Resources dir
	// sendColor: 'Green',		// <--- Defaults to "Green"
	// recieveColor: 'White',	// <--- Defaults to "White"
	// selectedColor: 'Blue',	// <--- Defaults to "Blue"
	// editable: true,			// <--- Defautls to true, do no change it
	// animated: false,			// <--- Defaults to true
	// buttonTitle: 'Something',	// <--- Defaults to "Send"
	// font: { fontSize: 12 ... },	// <--- Defaults to... can't remember
	// autocorrect: false,		// <--- Defaults to true
	// textAlignment: 'left',	// <--- Defaulst to left
	// textColor: 'blue',		// <--- Defaults to "black"
	returnType: Ti.SMSView.RETURNKEY_DONE, // <---- Defaults to Ti.SMSView.RETURNKEY_DEFAULT
	camButton: true				// <--- Defaults to false
			
});

win.add(textArea);

buttonBar.addEventListener('click', function(e){
	switch(e.index){
		case 0:	textArea.recieveMessage('Hello World!'); break;
		case 1: textArea.empty(); break;
		case 2: Ti.API.info(textArea.getAllMessages()); break;
		/*
		the camera button dissable property:
			case 3: textArea.camButtonDisabled = true; break;
			case 4: textArea.setCamButtonDisabled(false); break;
		*/
		case 3: textArea.sendButtonDisabled = true; break;
		case 4: textArea.setSendButtonDisabled(false); break;
	}
});

textArea.addEventListener('click', function(e){
	if(e.scrollView){
		textArea.blur();
	}
	// fires when clicked on the scroll view
	Ti.API.info('Clicked on the scrollview');
});
textArea.addEventListener('buttonClicked', function(e){
	// fires when clicked on the send button
    textArea.addLabel(new Date()+"");
    textArea.sendMessage(e.value);
});
textArea.addEventListener('camButtonClicked', function(){
	// fires when clicked on the camera button
	
	var options = Ti.UI.createOptionDialog({
		options: ['Photo Gallery', 'Cancel'],
		cancel: 1,
		title: 'Send a photo'
	});
	options.show();
	options.addEventListener('click', function(e) {
		if(e.index == 0){
		// --------------- open the photo gallery and send an image ------------------
			Titanium.Media.openPhotoGallery({
				success: function(event) {
					// uncomment to set a specific width, in this case 100
					// var image = Ti.UI.createImageView({image:event.media});
					// image.width = 100;
					// image.height = (100/event.media.width)*event.media.height
					//textArea.sendMessage(image.toBlob());
					textArea.sendMessage(event.media);
				},
				mediaTypes: [Ti.Media.MEDIA_TYPE_PHOTO]
			});
		// ---------------------------------------------------------------------------
		}
	});	
});

textArea.addEventListener('change', function(e){
	Ti.API.info(e.value);
});

textArea.addEventListener('messageClicked', function(e){
	// fires when clicked on a message
	if(e.text){
		Ti.API.info('Text: '+e.text);
	}
	if(e.image){
		Ti.API.info('Image: '+e.image);
	}
	Ti.API.info('Index: ' + e.index);
});

win.open({modal:true,animated:false});
