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


// index tracks page
Tracks.controller('tracksCtrl', ['$scope', '$http', function($scope, $http){
  $scope.tracks = [];
  $http.get('/tracks.json').then(function(response){
    response.data.map(function(track){
       var user = track.owner;
       var category = track.category;
       if(user){
        user = new User(user)
       }
       if(track.name){
         $scope.tracks.push(new Track(track, user, category))
       }
    })
  })

  $scope.sort='-popularity';

  $scope.updateSort = function(by){
    $scope.sort=by;
  }
}])


// track show page
Tracks.controller('coursesCtrl', ['$scope', '$http', function($scope, $http){
  $scope.courses = [];
  $http.get(window.location.pathname+'/courses').then(function(response){
    var courses = JSON.parse(response.data.courses);
    var userCourses = response.data.userCourses;
    courses.map(function(course){
      var users = course.users.map(function(u){return u.id})
      if(_.intersection(users, userCourses).length){
        var newCourse = new Course(course, 'checked_off')
        newCourse.ratingsView = newCourse.difficulty() + '<br>' + newCourse.rating();
        $scope.courses.push(newCourse)
      }
      else{
        $scope.courses.push(new Course(course, 'checked_on'))
      }

    })
  })
}])


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

