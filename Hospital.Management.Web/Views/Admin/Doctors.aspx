<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Admin/Master/Sidebar.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleCPH" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="CssCPH" runat="server">

    <style type="text/css">
        .table-striped tbody > tr > td {
            vertical-align: middle;
        }
    </style>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="NgCPH" runat="server">

    <script type="text/javascript">

        function Ctrl($scope, $http) {

            var urlLoad = "/Admin/AllDoctors";
            var urlSave = "/Admin/SaveDoctor";
            var urlDelete = "/Admin/DeleteDoctor";

            $scope.data = [];

            $scope.generate = function () {

                return { index: $scope.data.length + 1, name: "", surname: "", age: null, email: "", phone: "" };

            };

            $scope.load = function () {

                $scope.refresh();

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

                }, 250);

            };

            $scope.edit = function (row) {

                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > span.label.label-info").show();
                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > span.label.label-warning").hide();
                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > span.label.label-danger").hide();

                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > label").hide();
                $("#mainContainer > div.col-md-12 > div > div.widget-content > table > tbody > tr:nth-child(" + row + ") > td > input").show();

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
                <a href="/Admin/Doctors">Doctors</a>
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
                <h4><i class="icon-reorder"></i>Doctors</h4>
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
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="doctor in data">
                            <td>{{doctor.index}}</td>
                            <td>
                                <label>{{doctor.username}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="patient.username" placeholder="Username" />
                            </td>
                            <td>
                                <label>{{doctor.password}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="patient.password" placeholder="Password" />
                            </td>
                            <td>
                                <label>{{doctor.name}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="doctor.name" placeholder="Name" />
                            </td>
                            <td>
                                <label>{{doctor.surname}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="doctor.surname" placeholder="Surname" />
                            </td>
                            <td>
                                <label>{{doctor.age}}</label>
                                <input class="form-control input-width-small" type="text" style="display: none; margin-top: 6px;" ng-model="doctor.age" placeholder="Age" />
                            </td>
                            <td>
                                <label>{{doctor.email}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="doctor.email" placeholder="Email" />
                            </td>
                            <td>
                                <label>{{doctor.phone}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="doctor.phone" placeholder="Phone" />
                            </td>
                            <td>
                                <span class="label label-info" ng-click="save(doctor.index)" style="display: none">Save</span>
                                <span class="label label-warning" ng-click="edit(doctor.index)">Edit</span>
                                <span class="label label-danger" ng-click="delete(doctor.index)">Delete</span>
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
