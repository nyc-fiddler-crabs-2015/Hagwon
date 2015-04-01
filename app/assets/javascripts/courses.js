var Course = function(params, color){
  this.id          = params.id;
  this.url         = params.url;
  this.photo_url   = params.photo_url;
  this.name        = params.name;
  this.category_id = params.category_id;
  this.reviews = params.reviews;
  this.color = color;
  this.platform = params.platform;
}

var Courses = angular.module('trackApp', [])

Courses.controller('coursesCtrl', ['$scope', '$http', function($scope, $http){
  $scope.courses = [];
  $http.get(window.location.pathname+'/courses').then(function(response){
    var courses = JSON.parse(response.data.courses);
    var takenCourses = response.data.userCourses;
    courses.map(function(course){

      if (takenCourses.indexOf(course.id) > -1){
        newCourse = new Course(course, 'green')
      } else {
        newCourse = new Course(course, 'grey')
      }
      $scope.courses.push(newCourse)
    })
  })

}])


