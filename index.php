<html>
	<head>  
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>CONDUCTOR @ Lightwomb</title>
	
		
		<link href="css/reset.css" rel="stylesheet" type="text/css" />
		<link href='http://fonts.googleapis.com/css?family=Sorts+Mill+Goudy|Linden+Hill|Jura:400,600,500|Rosario|Six+Caps' rel='stylesheet' type='text/css'>

	
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<link href="css/controls.css" rel="stylesheet" type="text/css" />
		
		
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="js/jquery.jplayer.min.js"></script>  
		
		<script type="text/javascript" src="processing.js"></script>
		
		<script type="text/javascript" src="js/custom.js"></script>
		<script type="text/javascript" src="js/controls.js"></script>
	
		<script type="text/javascript" src="js/ready.js"></script>
		<script type="text/javascript" src="js/raphael.js"></script>

		
	</head>

	<body>
		<div id ="top">
			<h2> CONDUCTOR </h2> 
			<h4>Visual Metronome created by Lightwomb</h4>
			<div id ="oneliner"> 
				An interactive musical tool demonstrating different patterns used to stimulate music.
			</div>
		</div>
	
		<div id="jquery_jplayer_1" class="jp-jplayer"></div>
		<div id="jquery_jplayer_2" class="jp-jplayer"></div>
		
		
		<div id="log"></div>
		
		<div id = "boxes">
			<div id="views_top">
				<button id="btn1">#btn1</button>
				<button id="btn2">#btn2</button>		
			</div>
			<div id="views_bottom">
					<button id="btn4">#btn4</button>
				</div>
			<div id = "conductinator">
				<div id="comp">
					<canvas id="pde_canvas_comp" data-processing-sources="comp.pde"/></canvas>
				</div> 
				
				<div id ="transport_controls">
					
					<div class="transport_ctrls_main">
						<!-- main controllers (i.e. play/pause/stop) -->
						<button id="play">
							<label>Play</label>
							<div class="tooltip">
								<p>Click to Continue the Pattern</p>
							</div>
						</button>
						<button id="pause">
							<label>Pause</label>
							<div class="tooltip">
								<p>Click to Pause Pattern</p>
							</div>
						</button>
						<button id="stop">
							<label>Stop</label>
							<div class="tooltip">
								<p>Click to Stop the Pattern</p>
							</div>
						</button>							
					</div> <!-- .transport_cntrls_main -->
					
					<div class="transport_cntrls_loc">
						<!-- location controllers . . . -->
						<!-- beat -->
						<button id="go_to_beat_next">
							<!-- <div ="holder"></div> -->
							<label>Next Beat</label>
							<div class ="tooltip">
								<p>Click to move your position to the beginning of the next beat.</p>
							</div>
						</button>
						<button id="go_to_beat_previous">
							<label>Previous Beat</label>
							<div class="tooltip">
								<p>Click to move your position to the beginning of the previous beat.</p>
							</div>
						</button>
						<button id="go_to_beat_current">
							<label>Current Beat</label>
							<div class="tooltip">									
								<p>Click to move your position to the beginning of the current beat.</p>
							</div>
						</button>
						<!-- measure -->
						<button id="go_to_measure_next">
							<label>Next Measure</label>
							<div class="tooltip">
								<p>Click to go to next measure.</p>
							</div>
						</button>
						<button id="go_to_measure_previous">
							<label>Previous Measure</label>
							<div class="tooltip">
								<p>Click to go to previous measure.</p>
							</div>
						</button>
					</div> <!-- .transport_cntrls_loc -->

					<div class="transport_cntrls_tempo">
						<!-- tempo controllers -->
						<button id="btn5">
							<label>Tempo Up</label>
							<div class="tooltip">
								<p>Click to Increase Tempo</p>
							</div>
						</button>
						<button id="btn6">
							<label>Tempo Down</label>
							<div class="tooltip">
								<p>Click to Decrease Tempo</p>
							</div>
						</button>
					</div> <!-- .transport_cntrls_tempo -->
	
				</div> <!-- #transport_controls -->
				
				<div id="transport_current_state">
					<div id = "global" readonly="readonly">	
						<div class="transport_values_global">
							<textarea id="BPM"></textarea>  
							<textarea id="ts"></textarea>
						</div>
						<div class="transport_titles_global">
							<textarea id="title_BPM"></textarea>  
							<textarea id="title_ts"></textarea> 
						</div>	
					</div>
					<div id = "display">
						<textarea id="measure" class="transport_values"></textarea>  
						<textarea id="beat_num" class="transport_values" readonly="readonly"></textarea>
						<textarea id="beat" class="transport_values" readonly="readonly"></textarea>
						</br>				
						<textarea id="title_measure" class="transport_titles" readonly="readonly"></textarea>
						<textarea id="title_beat_num" class="transport_titles" readonly="readonly"></textarea>
						<textarea id="title_beat" class="transport_titles" readonly="readonly"></textarea>
					</div>
				</div>
			</div>
			<!-- <div id="holder"></div> -->
		</div>
		
<!--	<canvas id="dataViz" data-processing-sources="LastFMCrossDomainVizXML.pde" tabindex="0" width="600"  height="420"></canvas>   -->    		
	</body>
</html>