var Course = function(params, color){
  this.id          = params.id;
  this.url         = params.url;
  this.name        = params.name;
  this.category_id = params.category_id;
  this.reviews = params.reviews;
  this.color = color;
}

var Courses = angular.module('trackApp', [])

Courses.config([
  "$httpProvider", function($httpProvider) {
      $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);

Courses.controller('coursesCtrl', ['$scope', '$http', function($scope, $http){
  $scope.courses = [];
  $http.get(window.location.pathname+'/courses').then(function(response){
    console.log(response)

    var courses = JSON.parse(response.data.courses);
    var takenCourses = response.data.userCourses;
    console.log(response.data.userCourses)

    courses.map(function(course){

      if (takenCourses.indexOf(course.id) > -1){
        newCourse = new Course(course, 'green')
      } else {
        newCourse = new Course(course, 'grey')
      }
      console.log(newCourse)
      $scope.courses.push(newCourse)
    })
  })

}])


