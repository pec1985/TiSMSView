function rand() {
    var i,
    uarticle = ["The", "A", "One", "Some", "Any"],
    noun = ["boy", "girl", "dog", "town", "car", "kid", "boss", "table", "chair"],
    verb = ["drove", "jumped", "ran", "walked", "skipped", "insulted", "ran", "swam"],
    larticle = ["the", "a", "one", "some", "any"],
    preposition = ["to", "from", "over", "under", "on", "in between"],
    uarticleIndex,
    nounIndex1,
    nounIndex2,
    verbIndex,
    larticleIndex,
    prepositionIndex,
    space = " ",
	
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
	
    return (uarticle[uarticleIndex] +
			space + noun[nounIndex1] +
			space + verb[verbIndex] +
			space + preposition[prepositionIndex] +
			space + larticle[larticleIndex] +
			space + noun[nounIndex2] + ".");
}
Titanium.Pedro = require('ti.pedro');


function SMSWindow(){
	var win = Ti.UI.createWindow({tabBarHidden:'true'});
	var tf = Ti.Pedro.createSMSView({
									backgroundImage: 'bg.png',
									sendColor: 'White',
									recieveColor: 'Green',
									camButton:true
									});
	
	win.add(tf);
	tf.returnKeyType = Ti.Pedro.RETURNKEY_YAHOO;

	
	tf.addEventListener('buttonClicked', function(e) {
						if(tf.value == 'exit' || tf.value == 'Exit'){
							win.close();
						} else {
							tf.sendMessage(e.value);
							setTimeout(function() {
								   tf.recieveMessage(rand()); 
								   }, 1000);
						}
						});
	tf.addEventListener('camButtonClicked',function(e){
						alert(e.value);
						});
	
	win.addEventListener('open', function(){
						tf.recieveMessage('Type "exit" to exit'); 
						});
	

	
	return win;
}


function tg(){
	var tabGroup = Ti.UI.createTabGroup();
	var win = Ti.UI.createWindow({
								 backgroundColor:'#999'
								 });
	var btn = Ti.UI.createButton({
								 title:'open sms',
								 left:20,
								 right:20,
								 height:50
								 });
	btn2 = Ti.UI.createButton({
							  title:'close'
							  });
	win.setRightNavButton(btn2);
	win.add(btn);
	
	var tab = Ti.UI.createTab({
							  window:win
							  });
	
	tabGroup.addTab(tab);
	btn.addEventListener('click', function(){
						 tab.open(SMSWindow());
						 });
	btn2.addEventListener('click', function(){
						  tabGroup.close();
						  });
	return tabGroup;
}

function ng(){
	var mainWin = Ti.UI.createWindow();
	var win = Ti.UI.createWindow({
								 backgroundColor:'#666',
								 tabBarHidden:'true'
								 });
	var btn = Ti.UI.createButton({
								 title:'open sms',
								 left:20,
								 right:20,
								 height:50
								 });
	btn2 = Ti.UI.createButton({
							  title:'close'
							  });
	win.setRightNavButton(btn2);
	win.add(btn);
	
	var nav = Ti.UI.iPhone.createNavigationGroup({
							  window:win
							  });
	
	mainWin.add(nav);
	btn.addEventListener('click', function(){
						 var xx = SMSWindow();
						 nav.open(xx);
						 xx.addEventListener('close', function(){
											 nav.close(xx);
											 });
						 });
	btn2.addEventListener('click', function(){
						  mainWin.close();
						  });
	return mainWin;
}


function StartWindow(){
	
	var win = Ti.UI.createWindow({
								 backgroundColor: '#333',
								 layout:'vertical'
								 });
	
	var btn1 = Ti.UI.createButton({
								  title: 'tabGroup',
								  left:20,right:20,
								  height:40,
								  top:30
								  });
	
	win.add(btn1);
	
	var btn2 = Ti.UI.createButton({
								  title: 'mornal',
								  left:20,right:20,
								  height:40,
								  top:30
								  });
	
	win.add(btn2);
	
	var btn3 = Ti.UI.createButton({
								  title: 'modal',
								  left:20,right:20,
								  height:40,
								  top:30
								  });
	
	win.add(btn3);
	
	var btn4 = Ti.UI.createButton({
								  title: 'navigation',
								  left:20,right:20,
								  height:40,
								  top:30
								  });
	win.add(btn4);
	var btn5 = Ti.UI.createButton({
								  title: 'other context',
								  left:20,right:20,
								  height:40,
								  top:30
								  });
	
	win.add(btn5);
	
	btn5.addEventListener('click', function(){
						  var otherWin = Ti.UI.createWindow({
															url:'win.js'
						  });
						  otherWin.open();
						  });
	
	btn4.addEventListener('click', function(){
						  ng().open();
						  });
	btn3.addEventListener('click', function(){
						  SMSWindow().open({modal:true});
						  });
	btn2.addEventListener('click', function(){
						  SMSWindow().open();
						  });
	btn1.addEventListener('click', function(){
						  tg().open();
						  });
	
	return win;
}

StartWindow().open();
