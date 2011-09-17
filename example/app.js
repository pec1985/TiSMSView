Titanium.Pedro = require('ti.pedro');

var recieve = Ti.UI.createButton({
	title:'Recieve Message'
});

var empty = Ti.UI.createButton({
	title:'Empty'
});

var win = Ti.UI.createWindow({
	rightNavButton: recieve,
	leftNavButton: empty
});

var textArea = Ti.Pedro.createSMSView({
	backgroundColor: '#dae1eb',	// <--- Defaults to #dae1eb
	assets: 'assets',			// <--- Defauls to nothing, smsview.bundle can be places in the Resources dir
	// sendColor: 'Green',		// <--- Defaults to "Green"
	// recieveColor: 'White',	// <--- Defaults to "White"
	// selectedColor: 'Blue',	// <--- Defaults to "Blue"
	// editable: true,			// <--- Defautls to true, do no change it
	// animated: false,			// <--- Defaults to true
	buttonTitle: 'Something',	// <--- Defaults to "Send"
	// font: { fontSize: 12 ... },	// <--- Defaults to... can't remember
	// autocorrect: false,		// <--- Defaults to true
	// textAlignment: 'left',	// <--- Defaulst to left
	// textColor: 'blue',		// <--- Defaults to "black"
	// returnType: Ti.Pedro.RETURNKEY_DONE // <---- Defaults to Ti.Pedro.RETURNKEY_DEFAULT
	camButton: true				// <--- Defaults to false
			
});

win.add(textArea);

recieve.addEventListener('click', function(){
	textArea.recieveMessage('Hello World!');
});

empty.addEventListener('click', function(){
	textArea.empty();
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
});

win.open({modal:true,animated:false});