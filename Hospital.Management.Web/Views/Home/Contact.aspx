<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Home/Masters/Master.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">

    <style type="text/css">
        .contact-footer li {
            margin-left: 165px !important;
        }
    </style>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="server">


    <div class="container marg50">
        <div class="row">
            <div class="col-lg-6">
                <div class="promo-block">
                    <div class="promo-text">Alper Ekrem Yıldırım</div>
                    <div class="center-line"></div>
                </div>
                <div class="marg50">
                    <ul class="contact-footer">
                        <li><i class="icon-location"></i>Adress: 455 Martinson, Los Angeles</li>
                        <li><i class="icon-mobile"></i>Phone: 8 (043) 567 - 89 - 30</li>
                        <li><i class="icon-inbox"></i>Fax: 8 (057) 149 - 24 - 64</li>
                        <li><i class="icon-videocam"></i>Skype: companyname</li>
                        <li><i class="icon-mail"></i>E-mail: support@email.com</li>
                        <li><i class="icon-key"></i>Weekend: from 9 am to 6 pm</li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="promo-block">
                    <div class="promo-text">Emre Aksu</div>
                    <div class="center-line"></div>
                </div>
                <div class="marg50">
                    <ul class="contact-footer">
                        <li><i class="icon-location"></i>Adress: 455 Martinson, Los Angeles</li>
                        <li><i class="icon-mobile"></i>Phone: 8 (043) 567 - 89 - 30</li>
                        <li><i class="icon-inbox"></i>Fax: 8 (057) 149 - 24 - 64</li>
                        <li><i class="icon-videocam"></i>Skype: companyname</li>
                        <li><i class="icon-mail"></i>E-mail: support@email.com</li>
                        <li><i class="icon-key"></i>Weekend: from 9 am to 6 pm</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div style="height: 60px;"></div>

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="Least" runat="server">
</asp:Content>
