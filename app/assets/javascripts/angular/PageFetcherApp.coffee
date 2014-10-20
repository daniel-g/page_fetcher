angular.module('PageFetcherApp', ['ngRoute'])
  .config(['$routeProvider', ($routeProvider)->
    $routeProvider.
      when('/', {
        templateUrl: 'templates/welcome/index',
        controller: 'WelcomeController'
      }).
      when('/pages/:id', {
        templateUrl: 'templates/pages/show',
        controller: 'PageController'
      })
  ])
  .filter('fromNow', ->
    (input)->
      moment(input).fromNow()
  )
  .controller('WelcomeController', ['$scope', '$http', ($scope, $http)->
    $http.get('/api/pages.json')
      .success( (data, status, headers, config)->
        $scope.pages = data
      )
      .error( (data, status, headers, config)->
        console.log data
      )

    $scope.create = ->
      $http.post('/api/pages.json', {
        id: $scope.page.id
      })
        .success( (data, status, headers, config)->
          $scope.pages.push data
          $scope.page = {}
        )
        .error( (data, status, headers, config)->
          console.log data
        )


    @
  ])
  .controller('PageController', ['$scope', '$http', '$routeParams', ($scope, $http, $routeParams)->
    $http.get("/api/pages/#{ $routeParams.id }.json")
      .success( (data, status, headers, config)->
        $scope.page = data
      )
      .error( (data, status, headers, config)->
        console.log data
      )
    @
  ])
