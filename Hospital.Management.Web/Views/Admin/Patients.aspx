<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Admin/Master/Sidebar.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleCPH" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="CssCPH" runat="server">

    <style type="text/css">
        #mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr > td > span.label {
            margin-left: 5px;
        }
    </style>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="NgCPH" runat="server">

    <script type="text/javascript">

        function Ctrl($scope, $http) {

            var urlLoad = "/Admin/AllPatients";
            var urlSave = "/Admin/SavePatient";
            var urlDelete = "/Admin/DeletePatient";

            $scope.data = [];

            $scope.generate = function () {

                return { index: $scope.data.length + 1, name: "", surname: "", age: null, email: "", phone: "", insurance: "" };

            };

            $scope.load = function () {

                $http.get("/Admin/AllInsurances").success(function (data) {

                    $scope.insurances = data;

                    $scope.refresh();

                });

            };

            $scope.refresh = function () {

                $http.get(urlLoad).success(function (data) {

                    $scope.data = data;                   

                    NProgress.done();

                });

            };

            $scope.new = function () {

                $scope.data.push($scope.generate());

                setTimeout(function () {

                    $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:last-child > td > span.label.label-info").show();
                    $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:last-child > td > span.label.label-warning").hide();
                    $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:last-child > td > span.label.label-danger").hide();

                    $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:last-child > td > label").hide();
                    $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:last-child > td > input").show();
                    $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:last-child > td > select").show();

                }, 250);

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
                                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > select").hide();

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

            $scope.delete = function (row) {

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

                            $http.post(urlDelete, { id: $scope.data[row - 1].id }).success(function () {

                                $scope.refresh();

                                NProgress.done();

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

            $scope.show = function (row) {

                location.href = "/Admin/Patient/" + row;

            };

            $scope.load();

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
                <i class="icon-user crumb"></i>
                <a href="/Admin/Patients">Patients</a>
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
                <h4><i class="icon-reorder"></i>Patients</h4>
                <div class="toolbar no-padding">
                    <div class="btn-group">
                        <span class="label label-success" style="float: left; margin-top: 10px; margin-right: 10px;" ng-click="new()">New</span>
                        <span class="btn btn-xs widget-collapse"><i class="icon-angle-down"></i></span>
                    </div>
                </div>
            </div>
            <div class="widget-content">
                <table class="table table-hover table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Username</th>
                            <th>Password</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Age</th>
                            <th>E-mail</th>
                            <th>Phone</th>
                            <th>Insurance</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="patient in data">
                            <td>{{patient.index}}</td>
                            <td>
                                <label>{{patient.username}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="patient.username" placeholder="Username" />
                            </td>
                            <td>
                                <label>{{patient.password}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="patient.password" placeholder="Password" />
                            </td>
                            <td>
                                <label>{{patient.name}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="patient.name" placeholder="Name" />
                            </td>
                            <td>
                                <label>{{patient.surname}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="patient.surname" placeholder="Surname" />
                            </td>
                            <td>
                                <label>{{patient.age}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="patient.age" placeholder="Age" />
                            </td>
                            <td>
                                <label>{{patient.email}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="patient.email" placeholder="Email" />
                            </td>
                            <td>
                                <label>{{patient.phone}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="patient.phone" placeholder="Phone" />
                            </td>
                            <td>
                                <label>{{patient.insurance.name}}</label>
                                <select class="form-control" ng-model="patient.insurance" ng-options="i.name for i in insurances track by i.id" style="display:none">                                    
                                </select>
                            </td>
                            <td>
                                <span class="label label-info" ng-click="save(patient.index)" style="display: none">Save</span>
                                <span class="label label-info" ng-click="show(patient.index)">Show</span>
                                <span class="label label-warning" ng-click="edit(patient.index)">Edit</span>
                                <span class="label label-danger" ng-click="delete(patient.index)">Delete</span>
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
