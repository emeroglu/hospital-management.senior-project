﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Doctor/Master/Sidebar.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleCPH" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="CssCPH" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="NgCPH" runat="server">

    <script type="text/javascript">

        function Ctrl($scope, $http) {

            $scope.id = glossary.get("id");

            $scope.ex = {
                day: 3
            };

            $scope.load = function () {

                $http.get("/Admin/AllDoctors").success(function (data) {

                    $scope.doctors = data;

                    $http.get("/Admin/AllDiseases").success(function (data) {

                        $scope.diseases = data;

                        $http.get("/Admin/AllMedications").success(function (data) {

                            $scope.medications = data;

                            $http.get("/Admin/AllRooms").success(function (data) {

                                $scope.rooms = data;

                                $http.get("/Admin/AllInsurances").success(function (data) {

                                    $scope.insurances = data;

                                    $http.get("/Admin/AllExaminations").success(function (data) {

                                        $scope.examinations = data;

                                        NProgress.done();

                                    });

                                });

                            });

                        });

                    });

                });

                $scope.refresh();

            };

            $scope.generate = function () {

                return {
                    title: "", text: "", doctor: $scope.doctors[0]
                };

            };

            $scope.new = function () {

                $scope.patient.complaints.push($scope.generate());

                setTimeout(function () {

                    $("#tab_1_2 > table > tbody > tr:last-child > td > span.label.label-info").show();
                    $("#tab_1_2 > table > tbody > tr:last-child > td > span.label.label-warning").hide();

                    $("#tab_1_2 > table > tbody > tr:last-child > td > label").hide();
                    $("#tab_1_2 > table > tbody > tr:last-child > td > input").show();
                    $("#tab_1_2 > table > tbody > tr:last-child > td > select").show();

                }, 250);

            };

            $scope.refresh = function () {

                var id = document.URL.split("/")[document.URL.split("/").length - 1];

                $http.get("/Doctor/ComplaintsOfDoctor/" + id).success(function (data) {

                    $scope.doctor = data;

                    $scope.diagnosiss = [];
                    $scope.bookings = [];
                    $scope.transactions = [];
                    $scope.prescriptions = [];
                    $scope.examinationss = [];

                    for (var i = 0; i < $scope.doctor.complaints.length; i++) {

                        for (var j = 0; j < $scope.doctor.complaints[i].diagnosis.length; j++) {

                            $scope.diagnosiss.push({ diagnosis: $scope.doctor.complaints[i].diagnosis[j], patient: $scope.doctor.complaints[i].patient, complaintIndex: $scope.doctor.complaints[i].index });

                        }

                        for (var j = 0; j < $scope.doctor.complaints[i].bookings.length; j++) {

                            $scope.bookings.push({ booking: $scope.doctor.complaints[i].bookings[j], complaintIndex: $scope.doctor.complaints[i].index });

                        }

                        for (var j = 0; j < $scope.doctor.complaints[i].transactions.length; j++) {

                            $scope.transactions.push({ transaction: $scope.doctor.complaints[i].transactions[j], complaintIndex: $scope.doctor.complaints[i].index });

                        }

                        for (var j = 0; j < $scope.doctor.complaints[i].prescriptions.length; j++) {

                            $scope.prescriptions.push({ prescription: $scope.doctor.complaints[i].prescriptions[j], patient: $scope.doctor.complaints[i].patient, complaintIndex: $scope.doctor.complaints[i].index });

                        }

                        for (var j = 0; j < $scope.doctor.complaints[i].examinations.length; j++) {

                            $scope.examinationss.push({ examination: $scope.doctor.complaints[i].examinations[j], patient: $scope.doctor.complaints[i].patient, complaintIndex: $scope.doctor.complaints[i].index });

                        }

                    }

                    NProgress.done();

                });

            };

            $scope.edit = function (div, row) {

                $("#" + div + " > table > tbody > tr:nth-child(" + row + ") > td > span.label.label-warning").hide();

                $("#" + div + " > table > tbody > tr:nth-child(" + row + ") > td > label").hide();
                $("#" + div + " > table > tbody > tr:nth-child(" + row + ") > td > input").show();
                $("#" + div + " > table > tbody > tr:nth-child(" + row + ") > td > select").show();

            };

            $scope.save = function () {

                NProgress.start();

                for (var i = 0; i < $scope.patient.complaints.length; i++) {

                    $scope.patient.complaints[i].diagnosis = [];

                    for (var j = 0; j < $scope.diagnosiss.length; j++) {

                        $scope.patient.complaints[i].diagnosis.push($scope.diagnosiss[j].diagnosis);

                    }

                    $scope.patient.complaints[i].bookings = [];

                    for (var j = 0; j < $scope.bookings.length; j++) {

                        $scope.patient.complaints[i].bookings.push($scope.bookings[j].booking);

                    }

                    $scope.patient.complaints[i].transactions = [];

                    for (var j = 0; j < $scope.transactions.length; j++) {

                        $scope.patient.complaints[i].transactions.push($scope.transactions[j].transaction);

                    }

                    $scope.patient.complaints[i].prescriptions = [];

                    for (var j = 0; j < $scope.prescriptions.length; j++) {

                        $scope.patient.complaints[i].prescriptions.push($scope.prescriptions[j].prescription);

                    }

                    var temp = $scope.patient.complaints[i].examinations;

                    $scope.patient.complaints[i].examinations = [];

                    for (var j = 0; j < $scope.examinationss.length; j++) {

                        $scope.patient.complaints[i].examinations.push($scope.examinationss[j].examination);

                        $scope.patient.complaints[i].examinations[j].id2 = temp[j].id2;

                    }

                }

                $http.post("/Patient/SaveComplaints", { json: $scope.patient }).success(function () {

                    $scope.refresh();

                });

            };

            $scope.exam = function (complaintIndex) {

                $scope.examinationss.push({
                    examination: $scope.examinations[0], patient: $scope.doctor.complaints[complaintIndex - 1].patient, complaintIndex: complaintIndex
                });

                $("#tab_1_2").removeClass("active");
                $("#tab_1_3").addClass("active");
                $("#tab_1_4").removeClass("active");
                $("#tab_1_5").removeClass("active");
                $("#tab_1_6").removeClass("active");
                $("#tab_1_7").removeClass("active");

                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(1)").removeClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(2)").addClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(3)").removeClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(4)").removeClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(5)").removeClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(6)").removeClass("active");

                setTimeout(function () {

                    $("#tab_1_3 > table > tbody > tr:last-child > td > span.label.label-info").show();

                    $("#tab_1_3 > table > tbody > tr:last-child > td > label").hide();
                    $("#tab_1_3 > table > tbody > tr:last-child > td > input").show();
                    $("#tab_1_3 > table > tbody > tr:last-child > td > select").show();

                }, 250);

            };

            $scope.saveExam = function (complaintIndex) {

                NProgress.start();

                alert($scope.ex.day);

                $http.post("/Doctor/SaveExamination/" + $scope.doctor.complaints[complaintIndex - 1].id + "/" + $scope.ex.day, { examId: $scope.examinationss[$scope.examinationss.length - 1].examination.id }).success(function () {

                    $scope.refresh();

                });

            };

            $scope.diagnose = function (complaintIndex) {

                $scope.diagnosiss.push({
                    diagnosis: { id: 0, disease: $scope.diseases[0], comment: "" }, patient: $scope.doctor.complaints[complaintIndex - 1].patient, complaintIndex: complaintIndex
                });

                $("#tab_1_2").removeClass("active");
                $("#tab_1_3").removeClass("active");
                $("#tab_1_4").addClass("active");
                $("#tab_1_5").removeClass("active");
                $("#tab_1_6").removeClass("active");
                $("#tab_1_7").removeClass("active");

                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(1)").removeClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(2)").removeClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(3)").addClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(4)").removeClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(5)").removeClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(6)").removeClass("active");

                setTimeout(function () {

                    $("#tab_1_4 > table > tbody > tr:last-child > td > span.label.label-info").show();
                    $("#tab_1_4 > table > tbody > tr:last-child > td > span.label.label-warning").hide();

                    $("#tab_1_4 > table > tbody > tr:last-child > td > label").hide();
                    $("#tab_1_4 > table > tbody > tr:last-child > td > input").show();
                    $("#tab_1_4 > table > tbody > tr:last-child > td > select").show();

                }, 250);
            };

            $scope.saveDiagnosis = function (complaintIndex) {

                NProgress.start();

                $http.post("/Doctor/SaveDiagnosis/" + $scope.doctor.complaints[complaintIndex - 1].id, { json: $scope.diagnosiss[$scope.diagnosiss.length - 1].diagnosis }).success(function () {

                    $scope.refresh();

                });

            };

            $scope.prescribe = function (complaintIndex) {

                $scope.prescriptions.push({
                    prescription: { id: 0, medication: $scope.medications[0], comment: "" }, patient: $scope.doctor.complaints[complaintIndex - 1].patient, complaintIndex: complaintIndex
                });

                $("#tab_1_2").removeClass("active");
                $("#tab_1_3").removeClass("active");
                $("#tab_1_4").removeClass("active");
                $("#tab_1_5").addClass("active");
                $("#tab_1_6").removeClass("active");
                $("#tab_1_7").removeClass("active");

                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(1)").removeClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(2)").removeClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(3)").removeClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(4)").addClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(5)").removeClass("active");
                $("#mainContainer > div.col-md-12 > div > div.widget-content > div > div > div > ul > li:nth-child(6)").removeClass("active");

                setTimeout(function () {

                    $("#tab_1_5 > table > tbody > tr:last-child > td > span.label.label-info").show();
                    $("#tab_1_5 > table > tbody > tr:last-child > td > span.label.label-warning").hide();

                    $("#tab_1_5 > table > tbody > tr:last-child > td > label").hide();
                    $("#tab_1_5 > table > tbody > tr:last-child > td > input").show();
                    $("#tab_1_5 > table > tbody > tr:last-child > td > select").show();

                }, 250);

            };

            $scope.savePrescription = function (complaintIndex) {

                NProgress.start();

                $http.post("/Doctor/SavePrescription/" + $scope.doctor.complaints[complaintIndex - 1].id, { json: $scope.prescriptions[$scope.prescriptions.length - 1].prescription }).success(function () {

                    $scope.refresh();


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
                <a href="/Doctor/Index/{{id}}">{{doctor.name + ' ' + doctor.surname}}</a>
            </li>
            <li>
                <i class="fa fa-question-circle crumb"></i>
                <a href="/Doctor/Complaints/{{id}}">Complaints</a>
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
                <h4><i class="icon-reorder"></i>{{doctor.name + ' ' + doctor.surname}}</h4>
                <div class="toolbar no-padding">
                    <div class="btn-group">
                        <span class="btn btn-xs widget-collapse"><i class="icon-angle-down"></i></span>
                    </div>
                </div>
            </div>
            <div class="widget-content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Tabs-->
                        <div class="tabbable tabbable-custom">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#tab_1_2" data-toggle="tab">Complaints</a></li>
                                <li><a href="#tab_1_3" data-toggle="tab">Examinations</a></li>
                                <li><a href="#tab_1_4" data-toggle="tab">Diagnosis</a></li>
                                <li><a href="#tab_1_5" data-toggle="tab">Prescriptions</a></li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tab_1_2">
                                    <table class="table table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Patient</th>
                                                <th>Title</th>
                                                <th>Text</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="complaint in doctor.complaints">
                                                <td>{{complaint.index}}</td>
                                                <td>
                                                    <label>{{complaint.patient.name + ' ' + complaint.patient.surname}}</label>
                                                    <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="complaint.patient.name" placeholder="Name" disabled />
                                                </td>
                                                <td>
                                                    <label>{{complaint.title}}</label>
                                                    <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="complaint.title" placeholder="Title" />
                                                </td>
                                                <td>
                                                    <label>{{complaint.text}}</label>
                                                    <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="complaint.text" placeholder="Text" />
                                                </td>
                                                <td>
                                                    <span class="label label-info" ng-click="exam(complaint.index)">Exam</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="tab-pane" id="tab_1_3">
                                    <table class="table table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Complaint</th>
                                                <th>Patient</th>
                                                <th>Name</th>
                                                <th>Fee</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="examination in examinationss">
                                                <td>{{examination.examination.index}}</td>
                                                <td>{{examination.complaintIndex}}</td>
                                                <td>
                                                    <label>{{examination.patient.name + ' ' + examination.patient.surname}}</label>
                                                    <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="examination.patient.name" placeholder="Name" disabled />
                                                </td>
                                                <td>
                                                    <label>{{examination.examination.name}}</label>
                                                    <select class="form-control" ng-model="examination.examination" ng-options="e.name for e in examinations track by e.id" style="display: none">
                                                    </select>
                                                </td>
                                                <td>
                                                    <label>{{examination.examination.fee}}</label>
                                                    <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="examination.examination.fee" placeholder="Fee" disabled />
                                                </td>
                                                <td>
                                                    <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="ex.day" placeholder="Day" />
                                                </td>
                                                <td>
                                                    <span class="label label-warning" ng-if="examination.examination.status == 0">Pending</span>
                                                    <span class="label label-success" ng-if="examination.examination.status == 1">Taken</span>
                                                </td>
                                                <td>
                                                    <span class="label label-info" ng-click="saveExam(examination.complaintIndex)" ng-if="examination.examination.status == 0" style="display: none">Save</span>
                                                    <span class="label label-info" ng-click="diagnose(examination.complaintIndex)" ng-if="examination.examination.status == 1">Diagnose</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="tab-pane" id="tab_1_4">
                                    <table class="table table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Complaint</th>
                                                <th>Patient</th>
                                                <th>Disease</th>
                                                <th>Comment</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="diagnosis in diagnosiss">
                                                <td>{{diagnosis.diagnosis.index}}</td>
                                                <td>{{diagnosis.complaintIndex}}</td>
                                                <td>
                                                    <label>{{diagnosis.patient.name + ' ' + diagnosis.patient.surname}}</label>
                                                    <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="diagnosis.patient.name" placeholder="Name" disabled />
                                                </td>
                                                <td>
                                                    <label>{{diagnosis.diagnosis.disease.name}}</label>
                                                    <select class="form-control" ng-model="diagnosis.diagnosis.disease" ng-options="d.name for d in diseases track by d.id" style="display: none">
                                                    </select>
                                                </td>
                                                <td>
                                                    <label>{{diagnosis.diagnosis.comment}}</label>
                                                    <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="diagnosis.diagnosis.comment" placeholder="Comment" />
                                                </td>
                                                <td>
                                                    <span class="label label-warning" ng-click="edit('tab_1_4',diagnosis.diagnosis.index)">Edit</span>
                                                    <span class="label label-info" ng-click="saveDiagnosis(diagnosis.complaintIndex)" style="display: none">Save</span>
                                                    <span class="label label-warning" ng-click="prescribe(diagnosis.complaintIndex)">Write Prescription</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="tab-pane" id="tab_1_5">
                                    <table class="table table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Complaint</th>
                                                <th>Patient</th>
                                                <th>Medication</th>
                                                <th>Comment</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="prescription in prescriptions">
                                                <td>{{prescription.prescription.index}}</td>
                                                <td>{{prescription.complaintIndex}}</td>
                                                <td>
                                                    <label>{{prescription.patient.name + ' ' + prescription.patient.surname}}</label>
                                                    <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="prescription.patient.name" placeholder="Name" disabled />
                                                </td>
                                                <td>
                                                    <label>{{prescription.prescription.medication.name}}</label>
                                                    <select class="form-control" ng-model="prescription.prescription.medication" ng-options="m.name for m in medications track by m.id" style="display: none">
                                                    </select>
                                                </td>
                                                <td>
                                                    <label>{{prescription.prescription.comment}}</label>
                                                    <input class="form-control input-width-medium" type="text" style="display: none; margin-top: 6px;" ng-model="prescription.prescription.comment" placeholder="Comment" />
                                                </td>
                                                <td>
                                                    <span class="label label-warning" ng-click="edit('tab_1_5',prescription.prescription.index)">Edit</span>
                                                    <span class="label label-info" ng-click="savePrescription(prescription.complaintIndex)" style="display: none">Save</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!--END TABS-->
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content8" ContentPlaceHolderID="BodyBottomCPH" runat="server">
</asp:Content>
