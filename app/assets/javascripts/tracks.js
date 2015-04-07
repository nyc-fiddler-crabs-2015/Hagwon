var User = function(params){
  this.username= params.name;
  this.id = params.id;
}

var Track = function(params, user, category){
  this.name = params.name;
  this.id = params.id;
  this.user = user;
  this.category = category;
  this.resume = params.description;
  this.popularity = params.popularity;
}


var Tracks = angular.module('tracksApp', [])

Tracks.run(['$http', function($http) {
  $http.defaults.headers.common['Accept'] = 'application/json';
  $http.defaults.headers.common['Content-Type'] = 'application/json';
}]);

Tracks.filter('unsafe', function($sce) {
    return function(val) {
        return $sce.trustAsHtml(val);
    };
});



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

Tracks.controller('coursesCtrl', ['$scope', '$http', function($scope, $http){
  $scope.courses = [];
  $http.get(window.location.pathname+'/courses').then(function(response){
    var courses = JSON.parse(response.data.courses);
    var userCourses = response.data.userCourses;
    courses.map(function(course){
      var users = course.users.map(function(u){return u.id})
      if(_.intersection(users, userCourses).length){
        var newCourse = new Course(course, 'checked_off')
        newCourse.ratingsView = newCourse.difficulty();
        $scope.courses.push(newCourse)
      }
      else{
        $scope.courses.push(new Course(course, 'checked_on'))
      }

    })
  })
}])

Tracks.controller('newTrack', ['$scope', '$http', function($scope, $http){
  $scope.courses = [];
  $http.get(window.location.pathname+'.json').then(function(response){
    courses = JSON.parse(response.data.courses);
    category = response.data.category;
    courses.map(function(course){
      $scope.courses.push(new Course(course))
    })

  })
  $scope.titleName = {
    message: '',
    drag: 'Drag in here'
  };

  $scope.removeMessage = function(){
    $scope.titleName.drag="";
  }
}])

