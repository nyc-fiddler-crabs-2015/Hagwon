$(function() {
  $( ".check_function" ).on( "click", ".checked_on", function( event ) {
    $(this).removeClass("checked_on").addClass("checked_off");
      var course_id = $(this).data("id");
      console.log(course_id);
    $.ajax({
      url: '/courses/'+course_id+'/check',
      type: 'post'
    }).done(function( response ) {
    console.log(response);
  });

  });
   $( ".check_function" ).on( "click", ".checked_off", function( event ) {
    $(this).removeClass("checked_off").addClass("checked_on");

  });


});

