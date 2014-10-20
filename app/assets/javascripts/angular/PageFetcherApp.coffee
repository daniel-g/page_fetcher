angular.module('PageFetcherApp', [])
  .controller('PagesController', ['$scope', '$http', ($scope, $http)->
    $http.get('/api/pages.json')
      .success( (data, status, headers, config)->
        $scope.pages = data
      )
      .error( (data, status, headers, config)->
        console.log data
      )
    @
  ])
