var reader = new FileReader();
var memory = [];
var input = document.getElementById('your-rom');

input.onchange = function() {
	var file = input.files[0];
	reader.readAsArrayBuffer(file);
}

reader.onloadend = function (evt) {
		memory = new Uint8Array(evt.target.result);

		console.log(memory);
		document.querySelector('#result').innerHTML = readGameName();
}

function readGameName() {
	var gameTitle = "";

	for (var i = 0x134; i < 0x144; i++) {
		gameTitle += String.fromCharCode(memory[i]);
	}

	console.log(gameTitle);

	return gameTitle;
}
