var Course = function(params, color){

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
    response.data.courses.map(function(course){
      if(response.data.userCourses.includes(course.id)){
      }
      console.log(course)
      $scope.courses.push(course)
    })
  })

}])


