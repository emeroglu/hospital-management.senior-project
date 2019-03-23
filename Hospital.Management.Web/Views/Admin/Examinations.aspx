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

            var urlLoad = "/Admin/AllExaminations";
            var urlSave = "/Admin/SaveExamination";
            var urlDelete = "/Admin/DeleteExamination";

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
            $scope.orderBy('index', false);

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
                <i class="fa fa-search crumb"></i>
                <a href="/Admin/Examinations">Examinations</a>
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
                <h4><i class="icon-reorder"></i>Medical Examinations</h4>
                <div class="toolbar no-padding">
                    <div class="btn-group">
                        <span class="btn btn-xs widget-collapse"><i class="icon-angle-down"></i></span>
                    </div>
                </div>
            </div>
            <div class="widget-content">
                <table class="table table-hover table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Examination</th>
                            <th>Fee</th>
                            <th>Needs Room</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="exam in data | orderBy : predicate : reverse">
                            <td>{{exam.index}}</td>
                            <td>
                                <label>{{exam.name}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="exam.name" placeholder="Name" />
                            </td>
                            <td>
                                <label>{{exam.fee}} $</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="exam.fee" placeholder="Fee" />
                            </td>
                            <td>
                                <span class="label label-warning" ng-if="exam.needsRoom == 0">No</span>
                                <span class="label label-success" ng-if="exam.needsRoom == 1">Yes</span>
                            </td>
                            <td>
                                <span class="label label-info" ng-click="save(exam.index)" style="display: none">Save</span>
                                <span class="label label-warning" ng-click="edit(exam.index)">Edit</span>
                                <span class="label label-danger" ng-click="delete(exam.index)">Delete</span>
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
