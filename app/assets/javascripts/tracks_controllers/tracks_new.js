// New track form page
Tracks.controller('newTrack', ['$scope', '$http', function($scope, $http){
  $scope.courses = [];
  $http.get(window.location.pathname+'.json').then(function(response){
    courses = JSON.parse(response.data.courses);
    category = response.data.category;
    courses.map(function(course){
      newCourse = new Course(course)
      newCourse.ratingsView = newCourse.difficulty() + '<br>' + newCourse.rating();
      $scope.courses.push(newCourse)
    })
  })

  $scope.addCheck = function(course){
    course.dragged=true;
  }

}])
