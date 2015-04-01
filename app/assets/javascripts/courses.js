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

Course.prototype.rating = function(){
  if (this.reviews.length){
    var ratings = this.reviews.map(function(rev){
      return rev.rating
    })
    var average = ratings.reduce(function(previous, current){
      return previous + current;
    })
    return average/ratings.length;
  }else {
    return 0;
  }
}

Course.prototype.difficulty = function(){
  if(this.reviews.length){
    var difficulties = this.reviews.map(function(rev){
      return rev.difficulty;
    })
    var average = difficulties.reduce(function(previous, current){
    return previous + current;
  })
    return average/difficulties.length;
  }else{
    return 0;
  }
}

// Course.prototype.viewRatings = function(){
//   var html = '';
//   for(var x=0; x<this.rating();x++){
//     html+="<i class='fa fa-star star'></i>";
//   }
//   return html;
// }

// Course.prototype.viewDifficulty = function(){
//   html = ""
//   for(var x=0; x<this.difficulty();x++){
//     html+="<i class='fa fa-star star'></i>"
//   }
//   return html;
// }



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


