$(document).ready(function(){

	$(window).resize(function() {
      $("#boxes").css("width", $(window).width());
	});
	
  /* To-Do for jPlayer
  		php needs to: 
  			- create an array of <div> objects:
  					<div id="jquery_jplayer_1" class="jp-jplayer"></div>
  					etc.
				- create custom js functons for each #jquery_jplayer:
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
						etc.
	*/ 
  
  $("#jquery_jplayer_1").jPlayer({
		ready: function () {
			$(this).jPlayer("setMedia", {
				m4a: "music/click1.m4a",
				oga: "music/click1.ogg",
				mp3: "music/click1.mp3"	
			});
		},
		swfPath: "/music",
		solution:"html,flash",
		supplied: "m4a,ogg,mp3"
  }); 
  $("#jquery_jplayer_2").jPlayer({
		ready: function () {
			$(this).jPlayer("setMedia", {
				m4a: "music/click.m4a",
				oga: "music/click.ogg",
				mp3: "music/click.mp3"	
			});
		},
		swfPath: "/music",
		solution:"html,flash",
		supplied: "m4a,ogg,mp3"
  });
	
	/* custom fuctions */  
		
	var counter = 0;

$("#btn2").hide();
$("#btn4").hide();

$("#conductinator").hide();

$("#btn1").click(function() {
    $("#boxes").animate({
        width: $(window).width(),
        height: "500px"
    }, {
        duration: 250,
        step: function() {
            $("#btn1").hide();
            $("#btn2").show();
            $("#btn4").show();
			$("#conductinator").show();      
        }
    });

		$("#conductinator").animate({
		    left: "10%",
        height: "494px",
        width: "980px"
    }, {
        duration: 250,
        step: function() {

        }
    });

		$("#transport").animate({
				top: "10%",
				left: "4%",
        width: "20%",
        height: "80%"
    }, {
        duration: 250,
        step: function() {    
        }
    });
		
		$("#display").animate({
				top: "10%",
				left: "0%",
        width: "100%",
        height: "20%"
    }, {
        duration: 250,
        step: function() {
        
        }
    });
    $("#global").animate({
				left: "0%",
				top: "40%",
        width: "100%",
        height: "20%"
    }, {
        duration: 250,
        step: function() {
        
        }
    });

    function complete() {
       // counter++;
        //       $("<butt" + counter + "/>").text(this.id + " " + "Here is #box3 height: " //+ $("#box3").height() + " This is how many times we've run the complete() //function: " + counter).appendTo("#log");
    }
    
    $("#comp").fadeIn('slow',function(){bindtojplaya()});

    
});

$("#btn2").click(function() {
        
    $("#boxes").animate({
        width: $(window).width(),
        height: "10%"
    }, {
        duration: 250,
        step: function() {
           // $("#boxes.min").css("height", $("#boxes.min").height(), complete())
            $("#btn2").hide();
            $("#btn4").hide();
            $("#btn1").show();
            $("#conductinator").hide();
						noLoop_pjs(); 
        }
    });
    // hide button immediately

    function complete() {
        counter++;
    }
});

$("#btn4").click(function() {

    $("#comp").hide();
    
    $("#boxes").animate({
        width: $(window).width(),
        height: "116px"
    }, {
        duration: 250,
        step: function() {
            $("#btn2").hide();
            $("#btn1").show();
        }
    });
    
    $("#conductinator").animate({
        width: "980px",
        height: "110px"
    }, {
        duration: 250,
        step: function() {
            $("#btn4").hide();
            $("#btn2").show();
            $("#btn1").show();
        }
    });
 	
 	
 			$("#transport").animate({
				top: "5%",
				left: "0%",
        width: "100%",
        height: "90%"
    }, {
        duration: 250,
        step: function() {
        
        }
    });

			$("#display").animate({
				top: "5%",
				left: "5%",
        width: "40%",
        height: "90%"
    }, {
        duration: 250,
        step: function() {
        
        }
    });
    $("#global").animate({
				left: "50%",
				top: "5%",
        width: "45%",
        height: "90%"
    }, {
        duration: 250,
        step: function() {
        
        }
    });


    function complete() {
      //$("#transport").css("height", $("#transport").height()-1, complete())

    }
});
    
  // Click functions  
	$("#get_conductor_height").click(function () { 
		showHeight("conductor", $('#conductinator').height() ); 
	});	
	$("#play").click(function () { 
		noLoop_pjs();
		loop_pjs(); 
	});
	$("#pause").click(function () { 
		noLoop_pjs(); 
	});

	$("#btn5").click(function () { 
		BPM_up(); 
	});
	$("#btn6").click(function () { 
		BPM_down(); 
	});
		
//	 $.ajax({
//		type: "GET",
//		url: "getXML.php",
//		dataType: "html",
//		success: sendXMLToProcessing
//	});

});