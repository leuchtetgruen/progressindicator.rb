
var PInd = {
	PROGRESS_INDICATOR : ":;:",
	messageEl 	: null,
	progressEl : null,
	barEl			: null,
	titleEl		: null,
	
	onMessage : function(message) {
		parts = message.split(PInd.PROGRESS_INDICATOR);
		if (parts.length > 1) {
			type = parts[1]
			if (type=="TITLE") PInd.title(parts[2]);
			if (type=="PROGRESS") PInd.progress(parts[2], parts[3])
			if (type=="UNKNOWN_PROGRESS") PInd.unknownProgress(parts[2])
			if (type=="ERROR") PInd.error(parts[2])
		}
		else {
			console.log(message)
		}
	},
	
	config : function(messageEl, progressEl, barEl, titleEl) {
		PInd.messageEl = messageEl;
		PInd.progressEl = progressEl;
		PInd.barEl = barEl;
		PInd.titleEl = titleEl;
	},
	
	configDefault : function() {
		PInd.config(
			document.getElementById('message'),
			document.getElementById('progress'),
			document.getElementById('progressbar'),
			document.getElementById('title')
		);
	},
	
	progress : function(percent, message) {
		PInd.barEl.style.width = Math.round(percent) + "%";
		PInd.barEl.innerText = Math.round(percent) + "%";
		PInd.messageEl.innerHTML = message;
		PInd.messageEl.style.color = "#000";		
		
		if (percent==100)	{
			PInd.progressEl.className = PInd.progressEl.className.replace("active", "");
		}
	},
	
	unknownProgress : function(message) {
		PInd.messageEl.innerHTML = message;
	},
	
	error : function(message) {
		PInd.messageEl.innerHTML = message;
		PInd.messageEl.style.color = "#f00";
	},
	
	title : function(text) {
		PInd.titleEl.innerHTML = text;
	},
	
	progressViaWebSocket : function(url) {
		var socket = new WebSocket(url);
		socket.onmessage = function(msg) {
			PInd.onMessage(msg.data);
		}
	}
}