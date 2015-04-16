// track show page
Tracks.controller('coursesCtrl', ['$scope','$http', '$sce', function($scope, $http, $sce){
  $scope.courses = [];
  $http.get(window.location.pathname+'/courses').then(function(response){
    var courses = JSON.parse(response.data.courses);
    var userCourses = response.data.userCourses;
    courses.map(function(course){
      var users = course.users.map(function(u){return u.id})
      if(_.intersection(users, userCourses).length){
        var newCourse = new Course(course, 'checked_off')
        newCourse.ratingsView = $sce.trustAsHtml(newCourse.difficulty() + '<br>' + newCourse.rating());
        $scope.courses.push(newCourse)
      }
      else{
        $scope.courses.push(new Course(course, 'checked_on'))
      }

    })
  })

  $scope.reviewUrl = function(course){
    return '/courses/'+course.id+'/reviews';
  }


  $scope.check = function(course){

    if(course.checked=="checked_on"){
      course.checked = "checked_off"
      $('#modal'+ course.id +'').modal('toggle');
    }
    else{
      course.checked="checked_on"
    }
    $.post('/courses/'+course.id+'/check').then(function(response){
      console.log("WORKED")
    }).fail(function(response){console.log('didnt work')})

  }

}])
