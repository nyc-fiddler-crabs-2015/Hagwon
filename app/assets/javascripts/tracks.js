var User = function(params){
  this.username= params.username;
  this.id = params.id;
}

var Track = function(params, user, category){
  this.name = params.name;
  this.id = params.id;
  this.user = user;
  this.category = category;
  this.popularity = params.popularity;
}

var Tracks = angular.module('tracksApp', [])

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

  $scope.updateTrack = function(){
    var track = $scope.tracks.pop()
    $http.post('/tracks/'+track.id)
  }
}])

