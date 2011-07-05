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

var tf = textfield.createTextField({
	value:'hello world',
    autocorrect:'false'
});

window.add(tf);
window.add(btn);

btn.addEventListener('click', function(){
    tf.blur();
    alert(tf.value);
});
