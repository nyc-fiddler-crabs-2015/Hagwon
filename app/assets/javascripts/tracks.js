var Tracks = angular.module('tracksApp', [])


// Headers for rails
Tracks.run(['$http', function($http) {
  $http.defaults.headers.common['Accept'] = 'application/json';
  $http.defaults.headers.common['Content-Type'] = 'application/json';
}]);


//Add a filter that leaves html safe
Tracks.filter('unsafe', function($sce) {
  return function(val) {
    return $sce.trustAsHtml(val);
  };
});
