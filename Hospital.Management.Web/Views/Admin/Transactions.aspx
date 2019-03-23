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

            var urlLoad = "/Admin/AllTransactions";
            var urlSave = "/Admin/SaveTransaction";

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

                            alert(JSON.stringify($scope.data[row - 1]));

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
                <i class="fa fa-usd crumb"></i>
                <a href="/Admin/Transactions">Transactions</a>
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
                <h4><i class="icon-reorder"></i>Transactions</h4>
                <div class="toolbar no-padding">
                    <div class="btn-group">
                        <span class="label label-warning" style="float: left; margin-top: 10px; margin-right: 10px;" ng-click="orderBy('status',false)">Pending</span>
                        <span class="label label-success" style="float: left; margin-top: 10px; margin-right: 10px;" ng-click="orderBy('status',true)">Success</span>
                        <span class="btn btn-xs widget-collapse"><i class="icon-angle-down"></i></span>
                    </div>
                </div>
            </div>
            <div class="widget-content">
                <table class="table table-hover table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Payment Method</th>
                            <th>Amount</th>
                            <th>Provision Date</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="transaction in data | orderBy : predicate : reverse">
                            <td>{{transaction.index}}</td>
                            <td>
                                <label>{{transaction.name}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="transaction.name" placeholder="Name" />
                            </td>
                            <td>
                                <label>{{transaction.surname}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="transaction.surname" placeholder="Surname" />
                            </td>
                            <td>
                                <label ng-if="transaction.method == 0">Cash</label>
                                <label ng-if="transaction.method == 1">Credit Card</label>
                                <select class="form-control" value="{{transaction.method}}" style="display: none">
                                    <option value="0">Cash</option>
                                    <option value="1">Credit Card</option>
                                </select>
                            </td>
                            <td>
                                <label>{{transaction.amount}} $</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="transaction.amount" placeholder="Amount" />
                            </td>
                            <td>
                                <label>{{transaction.provisionDate}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="transaction.provisionDate" placeholder="Provision Date" />
                            </td>
                            <td>
                                <label>{{transaction.date}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="transaction.date" placeholder="Date" />
                            </td>
                            <td>
                                <span class="label label-warning" ng-if="transaction.status == 0">Pending</span>
                                <span class="label label-success" ng-if="transaction.status == 1">Success</span>
                            </td>
                            <td>
                                <span class="label label-info" ng-click="execute(transaction.index)" ng-show="transaction.status == 0">Execute</span>
                                <span class="label label-info" ng-click="save(transaction.index)" style="display: none">Save</span>
                                <span class="label label-warning" ng-click="edit(transaction.index)">Edit</span>
                                <span class="label label-danger" ng-click="delete(transaction.index)">Delete</span>
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
