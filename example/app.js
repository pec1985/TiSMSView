// random sentence generator for the resonse :)
function rand() {
	var i, uarticle = ["The", "A", "One", "Some", "Any"],
		noun = ["boy", "girl", "dog", "town", "car", "kid", "boss", "table", "chair"],
		verb = ["drove", "jumped", "ran", "walked", "skipped", "insulted", "ran", "swam"],
		larticle = ["the", "a", "one", "some", "any"],
		preposition = ["to", "from", "over", "under", "on", "in between"],
		uarticleIndex, nounIndex1, nounIndex2, verbIndex, larticleIndex, prepositionIndex, space = " ",

	uarticleIndex = Math.floor(Math.random() * uarticle.length);
	nounIndex1 = Math.floor(Math.random() * noun.length);
	nounIndex2 = Math.floor(Math.random() * noun.length);

	while (nounIndex1 == nounIndex2) {
		nounIndex2 = Math.floor(Math.random() * noun.length);
	}

	verbIndex = Math.floor(Math.random() * verb.length);
	larticleIndex = Math.floor(Math.random() * larticle.length);

	while (larticleIndex == uarticleIndex) {
		larticleIndex = Math.floor(Math.random() * larticle.length);
	}

	prepositionIndex = Math.floor(Math.random() * preposition.length);

	return (uarticle[uarticleIndex] + space + noun[nounIndex1] + space + verb[verbIndex] + space + preposition[prepositionIndex] + space + larticle[larticleIndex] + space + noun[nounIndex2] + ".");
}

Titanium.Pedro = require('ti.pedro');

// SMS Window, this is it!
function SMSWindow() {
	var win = Ti.UI.createWindow({
		tabBarHidden: 'true'
	});
	var tf = Ti.Pedro.createSMSView({
		backgroundImage: 'bg.png',
		sendColor: 'White',
		recieveColor: 'Green',
		camButton: true,
		animated:false
	});

	win.add(tf);
	tf.returnKeyType = Ti.Pedro.RETURNKEY_YAHOO;

	tf.addEventListener('buttonClicked', function(e) {
		if (tf.value == 'exit' || tf.value == 'Exit') {
			win.close();
		} else {
			tf.sendMessage(e.value);
			setTimeout(function() {
				tf.recieveMessage(rand());
			},
			1000);
		}
	});
//	tf.addEventListener('click', function(e){
//						alert(e);
//						});
	tf.addEventListener('camButtonClicked', function(e) {
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
												
						var image = Ti.UI.createImageView({image:event.media});
//						image.width = 100;
//						image.height = (100/event.media.width)*event.media.height
						tf.sendMessage(image);
						tf.sendMessage(image.toBlob());
						tf.sendMessage(image.toImage());
							
						//						tf.sendMessage(event.media);
						//						tf.sendMessage(event.media);
						//						tf.sendMessage(event.media);
						//						tf.sendMessage(event.media);
						//						tf.sendMessage(event.media);
						//						tf.sendMessage(event.media);
						//						tf.sendMessage(event.media);
					},
					mediaTypes: [Ti.Media.MEDIA_TYPE_PHOTO]
				});
			// ---------------------------------------------------------------------------
			}
		});

	});

	win.addEventListener('open', function() {
		tf.recieveMessage('Type "exit" to exit');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
//						 tf.sendMessage('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce accumsan vestibulum nisl, at aliquam nisl mattis ut. Morbi auctor hendrerit consequat. In hac habitasse platea dictumst.');
						 tf.loadMessages([
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()},
										  {send:rand()},
										  {recieve:rand()}
										 ]);
						 tf.animated = true;
	});

	return win;
}

// tab group
function tg() {
	var tabGroup = Ti.UI.createTabGroup();
	var win = Ti.UI.createWindow({
		backgroundColor: '#999'
	});
	var btn = Ti.UI.createButton({
		title: 'open sms',
		left: 20,
		right: 20,
		height: 50
	});
	btn2 = Ti.UI.createButton({
		title: 'close'
	});
	win.setRightNavButton(btn2);
	win.add(btn);

	var tab = Ti.UI.createTab({
		window: win
	});

	tabGroup.addTab(tab);
	btn.addEventListener('click', function() {
		tab.open(SMSWindow());
	});
	btn2.addEventListener('click', function() {
		tabGroup.close();
	});
	return tabGroup;
}

// navigation group
function ng() {
	var mainWin = Ti.UI.createWindow();
	var win = Ti.UI.createWindow({
		backgroundColor: '#666',
		tabBarHidden: 'true'
	});
	var btn = Ti.UI.createButton({
		title: 'open sms',
		left: 20,
		right: 20,
		height: 50
	});
	btn2 = Ti.UI.createButton({
		title: 'close'
	});
	win.setRightNavButton(btn2);
	win.add(btn);

	var nav = Ti.UI.iPhone.createNavigationGroup({
		window: win
	});

	mainWin.add(nav);
	btn.addEventListener('click', function() {
		var xx = Ti.UI.createWindow({
			url: 'win.js'
		});
		nav.open(xx);
		xx.addEventListener('close', function() {
			nav.close(xx);
		});
	});
	btn2.addEventListener('click', function() {
		mainWin.close();
	});
	return mainWin;
}

// our main widndow, the one used to select tests
function StartWindow() {

	var win = Ti.UI.createWindow({
		backgroundColor: '#333',
		layout: 'vertical'
	});

	var btn1 = Ti.UI.createButton({
		title: 'tabGroup',
		left: 20,
		right: 20,
		height: 40,
		top: 30
	});

	win.add(btn1);

	var btn2 = Ti.UI.createButton({
		title: 'normal',
		left: 20,
		right: 20,
		height: 40,
		top: 30
	});

	win.add(btn2);

	var btn3 = Ti.UI.createButton({
		title: 'modal',
		left: 20,
		right: 20,
		height: 40,
		top: 30
	});

	win.add(btn3);

	var btn4 = Ti.UI.createButton({
		title: 'navigation',
		left: 20,
		right: 20,
		height: 40,
		top: 30
	});
	win.add(btn4);

	var btn5 = Ti.UI.createButton({
		title: 'other context',
		left: 20,
		right: 20,
		height: 40,
		top: 30
	});

	win.add(btn5);

	btn5.addEventListener('click', function() {
		var otherWin = Ti.UI.createWindow({
			url: 'win.js'
		});
		otherWin.open();
	});

	btn4.addEventListener('click', function() {
		ng().open();
	});

	btn3.addEventListener('click', function() {
		SMSWindow().open({modal: true});
	
	});
	btn2.addEventListener('click', function() {
		SMSWindow().open();
	});
	btn1.addEventListener('click', function() {
		tg().open();
	});

	return win;
}

StartWindow().open();
