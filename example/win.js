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


var win = Ti.UI.currentWindow;
Titanium.Pedro = require('pec.tf');

var tf = Ti.Pedro.createTextField({
								  backgroundColor: '#b7d4fa',
								  sendColor: 'Purple',
								  recieveColor: 'Green'
								  });

win.add(tf);

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

win.addEventListener('open', function(){
					 tf.recieveMessage('Type "exit" to exit'); 
					 });
