var module = require('jp.msmc.tistoreproductview');

var window = Ti.UI.createWindow({
	layout:'vertical'
});

var faceBook = Ti.UI.createButton({
	top:50,
	title:'Show Facebook',
	font:{
		fontSize:15
	},
	width:150,
	height:Ti.UI.SIZE,
});
window.add(faceBook);

var twitter = Ti.UI.createButton({
	top:50,
	title:'Show Twitter',
	font:{
		fontSize:15
	},
	width:150,
	height:Ti.UI.SIZE,
});
window.add(twitter);

faceBook.addEventListener('click', function(e){
	module.showApp({
		appId:284882215,
		success:function(e){
			Ti.API.info("loaded successfully.");
		},
		error:function(e){
			Ti.API.info("loaded failed.");
		},
		closed:function(e){
			Ti.API.info("product view closed.");
		}
	});
});

twitter.addEventListener('click', function(e){
	module.showApp({
		appId:333903271,
		animated:false,
		success:function(e){
			Ti.API.info("loaded successfully.");
		},
		error:function(e){
			Ti.API.info("loaded failed.");
		},
		closed:function(e){
			Ti.API.info("product view closed.");
		}
	});
});

window.open();
