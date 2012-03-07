// CUSTOM FUNCTIONS
		
	function showHeight(ele, h) {
		var divh = document.getElementById('conductinator').scrollHeight;
		$("#conductinator").text("The height for the " + ele + " is " + h + "px." + "    Here's a random variable: " + divh);
		}  	
		
	// PJS Binds

	function bindtojplaya() {
		var bound = false;
		var pjs = Processing.getInstanceById('pde_canvas_comp');
			if(pjs!=null) {
				pjs.bindtojplaya(this);
				bound = true; 
			}
			if(!bound) {
				setTimeout(bindtojplaya, 100);
			}
		}
 	
 	// PJS	
	// SIZING
	function start_size() {
		// Processing variables
		var pjs = Processing.getInstanceById('pde_canvas_comp');
			
			var comp = document.getElementById('comp');
			var wide = comp.clientWidth;	
			var high = comp.clientHeight;	
		
		pjs.sizing(wide, high);
		pjs.sizingText(wide,high);
		
		}	
	// RESIZING
	function resizePJS() {
		var pjs = Processing.getInstanceById('pde_canvas_comp');

		var Cnator = document.getElementById('conductinator');
		
		var comp = document.getElementById('comp');
			
			var wide = comp.clientWidth;
			var high = comp.clientHeight;
					
			pjs.sizing(wide, high);
			pjs.sizingText(wide,high);
		  //pjs.sizingWindow(wide, high);
			
			if (widey<600) {
					document.getElementById('oneliner').style.top = -100;
					document.getElementById('oneliner').style.left = 0;
			} else {
					document.getElementById('oneliner').style.top = 13;
					document.getElementById('oneliner').style.left = 300;
			}
		}	
	window.onresize = function(){
											resizePJS();
											}					
	/* 
		This next series of functions uses a combination of:
			- the relevant .pde file
			- this .js file
			- and CSS manipulation
	*/	
	function setTextSize(texty, pads) {
		document.getElementById('beat').style.height = texty + pads;
		document.getElementById('BPM').style.height = texty + pads;
		document.getElementById('ts').style.height = texty + pads;
		document.getElementById('measure').style.height = texty + pads;
		// Display Titles for Values
		document.getElementById('title_beat').style.height = texty + pads;
		document.getElementById('beat_num').style.height = texty + pads;
		document.getElementById('title_beat_num').style.height = texty + pads;;
	
		document.getElementById('title_BPM').style.height = texty + pads;
		document.getElementById('title_ts').style.height = texty + pads;
		document.getElementById('title_measure').style.height = texty + pads;
		}
	function setTopSize(wide, high) {
		document.getElementById('top').style.height = high;
		}

	function showTransport(	
							title_beat, beat,
							title_beat_num, beat_num,
							title_BPM, BPM,
							title_ts, ts_top, ts_bottom, 
							title_measure, measure
							) {
		// set id values from PJS variables
		document.getElementById('beat').value = beat;
		document.getElementById('beat_num').value = beat_num;				
		document.getElementById('BPM').value = BPM;
		document.getElementById('ts').value = ts_top + '/' + ts_bottom;
		document.getElementById('measure').value = measure;
		// Display Titles for Values
		document.getElementById('title_beat').value = title_beat;
		document.getElementById('title_beat_num').value = title_beat_num;		
		document.getElementById('title_BPM').value = title_BPM;
		document.getElementById('title_ts').value = title_ts;
		document.getElementById('title_measure').value = title_measure;			
		}

// JPlayer Functions	
	// These are functions that are called from within PJS sketches (.pde files)
	function click(beat_num) {
		var beat_one = '#' + 'jquery_jplayer_' + '1';
		if(beat_num == 1) {
			$(beat_one).jPlayer('volume', .75);
			$(beat_one).jPlayer('play', 0);
			return false;
			}
		if(beat_num > 1) {
			$('#jquery_jplayer_2').jPlayer('volume', .75);
			$('#jquery_jplayer_2').jPlayer('play', 0);
			return false;
			}	
		}
	function pause() {
			$('#jquery_jplayer_1').jPlayer('pause');
			return false;
			}
	function stop() {
			$('#jquery_jplayer_1').jPlayer('stop');
			return false;
			}
	function playhead(position_playhead) {
		var player_playhead = position_playhead;
			$('#jquery_jplayer_1').jPlayer('playHead', player_playhead);
			return false;
			}
	function volume(position_vol) {
		var player_volume = position_vol/100;
			$('#jquery_jplayer_1').jPlayer('volume', player_volume);
			return false;
			}
			
	// JPlayer Containing communication with PROCESSING
	function getCurrentTIME() {
			var player_time = Processing.getInstanceById('raced');
				$('#jquery_jplayer_1').bind($.jPlayer.event.timeupdate, function(event) { // Adding a listener to report the time play began
					var jstime = event.jPlayer.status.currentTime;
					var percentduration = event.jPlayer.status.currentPercentAbsolute;	
							player_time.timecurrent(jstime);
							player_time.timepercent(percentduration);
				});
			}
			

// not currently called	
	function home() {
	 document.write("I am an alert box!");
	}
	function sendXMLToProcessing(data) {
		var dataViz = Processing.getInstanceById('dataViz');
			dataViz.parseXML(data); 
			}   



	function loop_pjs(){
			var pjs = Processing.getInstanceById('pde_canvas_comp');
			pjs.loop_sketch();
	}
	
	function noLoop_pjs(){
			var pjs = Processing.getInstanceById('pde_canvas_comp');
			pjs.noLoop_sketch();
	}
	function BPM_up(){
			var pjs = Processing.getInstanceById('pde_canvas_comp');
			pjs.tempo_increase();
			pjs.showTranny();
	}
	function BPM_down(){
			var pjs = Processing.getInstanceById('pde_canvas_comp');
			pjs.tempo_decrease();
			pjs.showTranny();
	}
	
	
	

