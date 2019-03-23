<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Admin/Master/Sidebar.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleCPH" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="CssCPH" runat="server">

    <style type="text/css">
        #mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr > td:nth-child(7) > span.label {
            margin-left: 5px;
        }
    </style>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="NgCPH" runat="server">

    <script type="text/javascript">

        function Ctrl($scope, $http) {

            var urlLoad = "/Admin/AllRooms";
            var urlSave = "/Admin/SaveRoom";

            $scope.data = [];

            $scope.load = function () {

                $scope.refresh();

            };

            $scope.refresh = function () {

                $http.get(urlLoad).success(function (data) {

                    $scope.data = data;

                    NProgress.done();

                });

            };

            $scope.edit = function (row) {

                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > span.label.label-info").show();
                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > span.label.label-warning").hide();
                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > span.label.label-danger").hide();

                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > label").hide();
                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > input").show();
                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > select").show();

            };

            $scope.save = function (row) {

                noty({
                    text: 'Are you sure?',
                    layout: "center",
                    animation: {
                        open: { height: 'toggle' }, // jQuery animate function property object
                        close: { height: 'toggle' }, // jQuery animate function property object
                        easing: 'swing', // easing
                        speed: 500 // opening & closing animation speed
                    },
                    buttons: [{
                        addClass: 'btn btn-primary',
                        text: 'Ok',
                        onClick: function ($noty) {

                            $noty.close();

                            NProgress.start();                            

                            $http.post(urlSave, { json: $scope.data[row - 1] }).success(function () {

                                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > span.label.label-info").hide();
                                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > span.label.label-warning").show();
                                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > span.label.label-danger").show();

                                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > label").show();
                                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > input").hide();

                                $scope.refresh();

                            });

                        }
                    }, {
                        addClass: 'btn btn-danger',
                        text: 'Cancel',
                        onClick: function ($noty) {
                            $noty.close();
                        }
                    }]
                });

            };

            $scope.orderBy = function (predicate, reverse) {

                $scope.predicate = predicate;
                $scope.reverse = reverse;

            };

            $scope.load();
            $scope.orderBy('number', false);

        }

    </script>

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="HeadCPH" runat="server">
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="BodyTopCPH" runat="server">
</asp:Content>

<asp:Content ID="Content6" ContentPlaceHolderID="BreadcrumbCPH" runat="server">

    <div class="crumbs">
        <ul id="breadcrumbs" class="breadcrumb">
            <li>
                <i class="icon-home crumb"></i>
                <a href="/">Team Medical</a>
            </li>
            <li>
                <i class="icon-user crumb"></i>
                <a href="/Admin/Index">Admin</a>
            </li>
            <li>
                <i class="fa fa-bed crumb"></i>
                <a href="/Admin/Rooms">Rooms</a>
            </li>
        </ul>

        <ul class="crumb-buttons">
            <li style="border-right: none"><a href="#">
                <i class="icon-calendar crumb"></i>
                <span><%: DateTime.Now.ToString("dd.MM.yyyy") %></span>
            </a></li>
        </ul>
    </div>

</asp:Content>

<asp:Content ID="Content7" ContentPlaceHolderID="BodyCPH" runat="server">

    <div class="col-md-12">
        <div class="widget box">
            <div class="widget-header">
                <h4><i class="icon-reorder"></i>Rooms</h4>
                <div class="toolbar no-padding">
                    <div class="btn-group">
                        <span class="label label-success" style="float: left; margin-top: 10px; margin-right: 10px;" ng-click="orderBy('status',false)">Available</span>
                        <span class="label label-danger" style="float: left; margin-top: 10px; margin-right: 10px;" ng-click="orderBy('status',true)">Occupied</span>
                        <span class="btn btn-xs widget-collapse"><i class="icon-angle-down"></i></span>
                    </div>
                </div>
            </div>
            <div class="widget-content">
                <table class="table table-hover table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Floor</th>
                            <th>Patient</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Status</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="room in data | orderBy: predicate : reverse">
                            <td>{{room.number}}</td>
                            <td>{{room.floor}}</td>
                            <td ng-if="room.patient.name != null">{{room.patient.name + ' ' + room.patient.surname}}</td>
                            <td ng-if="room.patient.name == null"></td>
                            <td>
                                <label>{{room.startDate}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="room.startDate" placeholder="Start Date" />
                            </td>
                            <td>
                                <label>{{room.endDate}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="room.endDate" placeholder="End Date" />
                            </td>
                            <td>
                                <span class="label label-success" ng-if="room.status == 0">Available</span>
                                <span class="label label-danger" ng-if="room.status == 1">Occupied</span>
                                <select class="form-control" ng-model="room.status" style="display: none">
                                    <option value="0">Available</option>
                                    <option value="1">Occupied</option>
                                </select>
                            </td>                           
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content8" ContentPlaceHolderID="BodyBottomCPH" runat="server">
</asp:Content>
