var reader = new FileReader();
var fileByteArray = [];
var input = document.getElementById('your-rom');

input.onchange = function()
{
	var file = input.files[0];
	reader.readAsArrayBuffer(file);
}

reader.onloadend = function (evt) {
	//if (evt.target.readyState == FileReader.DONE) {
		var arrayBuffer = evt.target.result;
		var array = new Uint8Array(arrayBuffer);

		console.log(array);
	//}
}
