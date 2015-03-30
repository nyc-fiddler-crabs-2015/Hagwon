    $(function() {
      var arraySelected = [];

      $('#row_course_selection').children('li').each(function () {
            arraySelected.push($(this).data("id"));
        });

      $('#position').val(arraySelected)
      $( "#sidebar_course_choices" ).sortable({
        connectWith: "#row_course_selection",
        update: function(){
          $("#sidebar_course_choices").children('li').each(function () {
            $(this).attr("class", "col-xs-12 col-md-12 ui-sortable-handle");
            var courseBox = '#course_' + $(this).data("id");
          $(courseBox).prop('checked', false);
          });

        }
      });
      $( "#row_course_selection" ).sortable({
        connectWith: "#sidebar_course_choices",
        update: function(event){
          arraySelected = [];
          $(event.target).children('li').each(function () {
            arraySelected.push($(this).data("id"));
            var courseBox = '#course_' + $(this).data("id");
          // console.log(courseBox);
          // courseBox.attr("checked", !courseBox.attr("checked"));
          $(courseBox).prop('checked', true);
        });

          $("#row_course_selection").children('li').each(function () {
            $(this).attr("class", "col-xs-6 col-md-3");
          });
          //* submit array to hidden input in form
          $('#position').val(arraySelected)
          console.log(arraySelected)

        }
      });
      $( "#sidebar_course_choices", "#row_course_selection" ).disableSelection();
    });

// row_course_selection
// sidebar_course_choices