// Conductor Controls
// by Jared Boria

// Examples are from jQuery . . . Novice to Ninja

// LONG FORM
// $(document).ready(function() {
// 	
// });

// SHORT FORM
$(function() {
//	$('button').attr("name").appendTo(this);
	
	
	// tooltip etc. . .
	$('.tooltip').hide();
	
	$('button').hover(
		function() {
			$('.tooltip', this).show();		
		},
		function() {
			$('.tooltip', this).hide();		
		}
	);

}); // end of $(document).ready()