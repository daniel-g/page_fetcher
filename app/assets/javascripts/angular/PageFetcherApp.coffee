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
  .service('Status', ->
    {
      initialize: (status) ->
        @status = status
      setLoading: (isLoading) ->
        @status.loading = isLoading
    }
  )
  .controller('LoadingController', ['$scope', 'Status', ($scope, Status)->
    $scope.status = {
      loading: false
    }
    Status.initialize($scope.status)
    @
  ])
  .controller('WelcomeController', ['$scope', '$http', ($scope, $http)->
    $scope.pages = []

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
  .controller('PageController', ['$scope', '$http', '$routeParams', 'Status', ($scope, $http, $routeParams, Status)->
    Status.setLoading(true)
    $http.get("/api/pages/#{ $routeParams.id }.json")
      .success( (data, status, headers, config)->
        $scope.page = data
      )
      .error( (data, status, headers, config)->
        console.log data
      )
      .finally(->
        Status.setLoading(false)
      )
    @
  ])
