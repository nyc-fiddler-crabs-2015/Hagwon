    $(function() {

      $( "#sidebar_course_choices" ).sortable({connectWith: "#row_course_selection"});
      $( "#row_course_selection" ).sortable({connectWith: "#sidebar_course_choices", update: function(event){
        var arraySelected = [];
        $(event.target).children('li').each(function () {
          arraySelected.push($(this).data("id"));
          courseBox = '#course_' + $(this).data("id");
          // console.log(courseBox);
          // courseBox.attr("checked", !courseBox.attr("checked"));
          $(courseBox).prop('checked', true);
        });
        $("#row_course_selection").children('li').each(function () {
          $(this).attr("class", "col-xs-6 col-md-3");
        });

        console.log(arraySelected);
      }
    });
      $( "#sidebar_course_choices", "#row_course_selection" ).disableSelection();
    });

// row_course_selection
// sidebar_course_choices