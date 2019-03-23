<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Doctor/Master/Sidebar.Master" Inherits="System.Web.Mvc.ViewPage" %>

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

            var urlLoad = "/Doctor/PatientsOfDoctor/" + glossary.get("id");                        

            $scope.id = glossary.get("id");

            $scope.data = [];            

            $scope.load = function () {

                $http.get(urlLoad).success(function (data) {

                    $scope.patients = data;

                    NProgress.done();

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
                <a href="/Doctor/Index/{{id}}">Doctor</a>
            </li>
            <li>
                <i class="icon-user crumb"></i>
                <a href="/Doctor/Patients/{{id}}">Patients</a>
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
                            <th>Age</th>
                            <th>E-mail</th>
                            <th>Phone</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="patient in patients">
                            <td>{{patient.index}}</td>
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
                                <input class="form-control input-width-small" type="text" style="display: none; margin-top: 6px;" ng-model="patient.age" placeholder="Age" />
                            </td>
                            <td>
                                <label>{{patient.email}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="patient.email" placeholder="Email" />
                            </td>
                            <td>
                                <label>{{patient.phone}}</label>
                                <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="patient.phone" placeholder="Phone" />
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
