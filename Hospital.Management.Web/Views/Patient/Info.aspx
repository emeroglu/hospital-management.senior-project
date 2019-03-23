<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Patient/Master/Sidebar.Master" Inherits="System.Web.Mvc.ViewPage" %>

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

            var urlLoad = "/Patient/ById/" + glossary.get("id");
            var urlSave = "/Patient/SaveInfo/" + glossary.get("id");            

            $scope.id = glossary.get("id");

            $scope.data = [];           

            $scope.load = function () {

                $http.get("/Patient/AllInsurances").success(function (data) {

                    $scope.insurances = data;

                    $scope.refresh();

                });

            };

            $scope.refresh = function () {

                $http.get(urlLoad).success(function (data) {

                    $scope.info = data;

                    NProgress.done();

                });

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

                            $http.post(urlSave, { json: $scope.info }).success(function () {

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
                <a href="/Patient/Index/{{id}}">{{info.name + ' ' + info.surname}}</a>
            </li>
            <li>
                <i class="icon-pencil crumb"></i>
                <a href="/Patient/Info/{{id}}">Info</a>
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
                <h4><i class="icon-reorder"></i>Info</h4>
                <div class="toolbar no-padding">
                    <div class="btn-group"> 
                        <span class="label label-info" style="float: left; margin-top: 10px; margin-right: 10px;" ng-click="save()">Save</span>                       
                        <span class="btn btn-xs widget-collapse"><i class="icon-angle-down"></i></span>
                    </div>
                </div>
            </div>
            <div class="widget-content">
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <form class="form-horizontal row-border" action="#">
                            <div class="form-group">
                                <label class="col-md-3 control-label">Username:</label>
                                <div class="col-md-9">
                                    <input type="text" name="regular" class="form-control" ng-model="info.username">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Password:</label>
                                <div class="col-md-9">
                                    <input type="text" name="regular" class="form-control" ng-model="info.password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Name:</label>
                                <div class="col-md-9">
                                    <input type="text" name="regular" class="form-control" ng-model="info.name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Surname:</label>
                                <div class="col-md-9">
                                    <input type="text" name="regular" class="form-control" ng-model="info.surname">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Age:</label>
                                <div class="col-md-9">
                                    <input type="text" name="regular" class="form-control" ng-model="info.age">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Email:</label>
                                <div class="col-md-9">
                                    <input type="text" name="regular" class="form-control" ng-model="info.email">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Phone:</label>
                                <div class="col-md-9">
                                    <input type="text" name="regular" class="form-control" ng-model="info.phone">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Insurance:</label>
                                <div class="col-md-9">
                                    <select class="form-control" ng-model="info.insurance" ng-options="i.name for i in insurances track by i.id">
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content8" ContentPlaceHolderID="BodyBottomCPH" runat="server">
</asp:Content>
