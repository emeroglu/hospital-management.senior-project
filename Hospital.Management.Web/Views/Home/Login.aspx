<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Home/Masters/Master.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">

    <script type="text/javascript">

        function Login() {

            var username = document.getElementById("txtUsername").value;
            var password = document.getElementById("txtPassword").value;

            $.ajax({
                "method": "POST",
                "url": "/Home/LogTheUserIn",
                "data": { "username": username, "password": password },
                "success": function (data) {
                    location.href = data;
                }
            });

        }

        function SaveUser() {
            
            var user = {
                "name": document.getElementById("txtName").value,
                "surname": document.getElementById("txtSurname").value,                
                "age": document.getElementById("txtAge").value,
                "phone": document.getElementById("txtPhone").value,
                "email": document.getElementById("txtEmail").value,
                "username": document.getElementById("txtNewUsername").value,
                "password":document.getElementById("txtNewPassword").value
            };

            $.ajax({
                "method": "POST",
                "url": "/Home/SaveUser",
                "data": user,
                "success": function () {
                    location.reload();
                }
            });

        }

    </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="server">

    <div class="container marg50">

        <div class="row">

            <div class="col-lg-4">
                <div class="promo-block">
                    <div class="promo-text">Login</div>
                    <div class="center-line"></div>
                </div>
                <p class="text_cont">
                    <input type="text" id="txtUsername" placeholder="Username" class="input-cont-textarea marg25">
                </p>
                <p class="text_cont">
                    <input type="password" id="txtPassword" placeholder="Password" class="input-cont-textarea">
                </p>
                <p>
                    <input type="submit" id="btnLogin" class="btn btn-info pull-right" value="Login" onclick="Login()">
                </p>
            </div>
            <div class="col-lg-2"></div>
            <div class="col-lg-6">
                <div class="promo-block">
                    <div class="promo-text">Register</div>
                    <div class="center-line"></div>
                </div>
                <div class="col-lg-6">
                    <p class="text_cont">
                        <input type="text" id="txtName" placeholder="Name" class="input-cont-textarea marg25">
                    </p>
                </div>
                <div class="col-lg-6">
                    <p class="text_cont">
                        <input type="text" id="txtSurname" placeholder="Surname" class="input-cont-textarea marg25">
                    </p>
                </div>
                <div class="col-lg-6">
                    <p class="text_cont">
                        <input type="text" id="txtAge" placeholder="Age" class="input-cont-textarea">
                    </p>
                </div>
                <div class="col-lg-6">
                    <p class="text_cont">
                        <input type="text" id="txtPhone" placeholder="Phone" class="input-cont-textarea">
                    </p>
                </div>                
                <div class="col-lg-6">
                    <p class="text_cont">
                        <input type="text" id="txtEmail" placeholder="Email" class="input-cont-textarea">
                    </p>
                </div>
                <div class="col-lg-6">
                    <p class="text_cont">
                        <input type="text" id="txtNewUsername" placeholder="Username" class="input-cont-textarea">
                    </p>
                </div>
                <div class="col-lg-6">
                    <p class="text_cont">
                        <input type="text" id="txtNewPassword" placeholder="Password" class="input-cont-textarea">
                    </p>
                </div>
                <div class="col-lg-12">
                    <p>
                        <input type="submit" id="btnRegister" class="btn btn-info pull-right" value="Register" onclick="SaveUser()">
                    </p>
                </div>
            </div>

        </div>

    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="Least" runat="server">
</asp:Content>
