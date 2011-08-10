// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'white'
});

window.open();

// TODO: write your module tests here
var textfield = require('pec.tf');

var btn = Ti.UI.createButton({
	top:10,
	left:10,
	right:10,
	height:44,
	title:'blur'
});

var focus = Ti.UI.createButton({
	top:100,
	left:10,
	right:10,
	height:44,
	title:'focus'
});

var tf = textfield.createTextField({
	value:'hello world',
    color:'black',
	backgroundColor:'#93baf0',
	buttonTitle:'send'
});

window.add(tf);
window.add(btn);
window.add(focus);

btn.addEventListener('click', function(){
	tf.blur();
});
focus.addEventListener('click', function(){
	tf.focus();
});

tf.addEventListener('blur', function(e){
	Ti.API.info(e);
});
tf.addEventListener('buttonClicked', function(e){
	Ti.API.info(e);
});
tf.addEventListener('change', function(e){
	Ti.API.info(e);
});
tf.addEventListener('heightChanged', function(e){
	Ti.API.info(e);
});
