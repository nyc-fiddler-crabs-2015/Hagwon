var Courses = angular.module('trackApp', [])

Courses.config([
  "$httpProvider", function($httpProvider) {
      $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);

Courses.controller('coursesCtrl', ['$scope', '$http', function($scope, $http){
  $scope.courses = [];
  $http.get(window.location.pathname+'/courses').then(function(response){
    response.data.map(function(course){
      $scope.courses.push(course)
    })
  })

}])


