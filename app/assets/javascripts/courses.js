var Courses = angular.module('trackApp', [])
Courses.controller('coursesCtrl', ['$scope', '$http', function($scope, $http){
  $scope.courses = [];
  $http.get(window.location.pathname+'/courses').then(function(response){
    response.data.map(function(course){
      $scope.courses.push(course)
    })
  })

}])