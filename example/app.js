// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.
function random1() {
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

function random2()
 {
    var names = [];
    names[0] = "Christian";
    names[1] = "Guy Smith";
    names[2] = "Christina";
    names[3] = "Marty";
    names[4] = "Bob the dog";
    names[5] = "Charlie the dog";

    var verbs = [];
    verbs[0] = "made love to";
    verbs[1] = "pooped on";
    verbs[2] = "kissed";
    verbs[3] = "licked";
    verbs[4] = "peed on";
    verbs[5] = "rubbed against";
    verbs[6] = "inappropriately touched";
    verbs[7] = "picked ticks off of";
    verbs[8] = "threw poo at";
    verbs[9] = "kicked";
    verbs[10] = "caressed";

    var phrases = [];
    phrases[0] = "and danced throughout the night.";
    phrases[1] = "and then turned and ran as fast as possible.";
    phrases[2] = "and spit in disqust.";
    phrases[3] = "and immediately had to take a shower.";
    phrases[4] = "and then did it again.";
    phrases[5] = "and then threw up.";
    phrases[6] = "and began to poo violently.";
    phrases[7] = "and cried like a baby.";
    phrases[8] = "and begged for more.";
    phrases[9] = "and fell over dead.";

    var personOneNumber = (Math.floor(Math.random() * names.length));
    var personOne = names[personOneNumber];
    // first name
    var personTwoNumber = personOneNumber;
    // sets the first name = to the second name for testing purposes
    while (personTwoNumber == personOneNumber) {
        personTwoNumber = (Math.floor(Math.random() * names.length));
        var personTwo = names[personTwoNumber];
        // second name
    }

    var verbNumber = (Math.floor(Math.random() * verbs.length));
    var verbPairing = verbs[verbNumber];
    // gives us the verb
    var phrasePairingNumber = (Math.floor(Math.random() * phrases.length));
    var phrasePairing = phrases[phrasePairingNumber];
    // gives us the end phrase
    var pairingSentence = personOne + " " + verbPairing + " " + personTwo + " " + phrasePairing;

    return pairingSentence;

}

// open a single window
var window = Ti.UI.createWindow({
    backgroundColor: 'white'
});

window.open({
    modal: true
});

// TODO: write your module tests here
var textfield = require('pec.tf');

var btn = Ti.UI.createButton({
    title: 'recieve'
});

var tf = textfield.createTextField({
    backgroundColor: '#b7d4fa',
    sendColor: 'Purple',
    recieveColor: 'Green'
});

window.add(tf);
window.setRightNavButton(btn);

btn.addEventListener('click',
function() {
    tf.recieveMessage(random1());
});
var x = 0;

tf.addEventListener('buttonClicked',
function(e) {
    tf.sendMessage(e.value);
    setTimeout(function() {
        switch (x)
        {
        case 0:
            tf.recieveMessage(random2());
            x = 1;
            break;
        case 1:
            tf.recieveMessage(random1());
            x = 0;
            break;
        }
    },
    1000);
});
tf.addEventListener('change',
function(e) {
    });
tf.addEventListener('heightChanged',
function(e) {
    alert(e);
});
tf.addEventListener('blur',
function(e) {
    alert(e);
});
tf.addEventListener('focus',
function(e) {
    alert(e);
});