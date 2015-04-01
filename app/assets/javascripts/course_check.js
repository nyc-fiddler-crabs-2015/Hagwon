$(function() {

  $( ".check_function" ).on( "click", ".checked_on", function( event ) {
    $(this).removeClass("checked_on").addClass("checked_off");
    var course_id = $(this).data("id");
    console.log(course_id);
          $('#modal'+ course_id +'').modal('toggle');

    toggle_check(course_id).done(function( response ) {
      console.log("response");
    });
  });

  $( ".check_function" ).on( "click", ".checked_off", function( event ) {
    var course_id = $(this).data("id");

    $(this).removeClass("checked_off").addClass("checked_on");
    toggle_check(course_id);
  });
});

var toggle_check = function(id){
  var course_id = id;
  return $.ajax({
    url: '/courses/'+course_id+'/check',
    type: 'post'
  });

}
