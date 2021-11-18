'use strict';

angular.module('bahmni.common.displaycontrol.custom')
    .directive('patientAppointmentsDashboard', ['$http', '$q', '$window','appService', function ($http, $q, $window, appService) {
        var link = function ($scope) {
            $scope.contentUrl = appService.configBaseUrl() + "/customDisplayControl/views/patientAppointmentsDashboard.html";
            var getUpcomingAppointments = function () {
                var params = {
                    q: "bahmni.sqlGet.upComingAppointments",
                    v: "full",
                    patientUuid: $scope.patient.uuid
                };
                return $http.get('/openmrs/ws/rest/v1/bahmnicore/sql', {
                    method: "GET",
                    params: params,
                    withCredentials: true
                });
            };
            var getPastAppointments = function () {
                var params = {
                    q: "bahmni.sqlGet.pastAppointments",
                    v: "full",
                    patientUuid: $scope.patient.uuid
                };
                return $http.get('/openmrs/ws/rest/v1/bahmnicore/sql', {
                    method: "GET",
                    params: params,
                    withCredentials: true
                });
            };
            $q.all([getUpcomingAppointments(), getPastAppointments()]).then(function (response) {
                $scope.upcomingAppointments = response[0].data;
                $scope.upcomingAppointmentsHeadings = _.keys($scope.upcomingAppointments[0]);
                $scope.pastAppointments = response[1].data;
                $scope.pastAppointmentsHeadings = _.keys($scope.pastAppointments[0]);
            });

            $scope.goToListView = function () {
                $window.open('/bahmni/appointments/#/home/manage/appointments/list');
            };
        };
        return {
            restrict: 'E',
            link: link,
            scope: {
                patient: "=",
                section: "="
            },
            template: '<ng-include src="contentUrl"/>'
        };
    }]);