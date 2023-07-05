<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="eStoreProduct.model.admin.output.AdminViewPayments" %>
<%@ page import="java.util.*" %>

 
 <!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Payment Details</title>
   <link rel="stylesheet" type="text/css" href="./css/viewPayments.css">

 
    <script src="./js/viewPayments.js"></script>
 
</head>
<body>
<div id="paymentcontent">
<div class="container" >
    <div class="filter-form">
        <form id="filterForm" class="fas fa-calendar-alt">
            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" required>
            <br>
            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" required>
            <br>
            <button type="submit">Filter</button>
        </form>
    </div>
    <div align="right">
        <b><label for="filterSelect">Filter By</label></b>
        <select id="filterSelect" onchange="filterPayments()" class="form-select filter-select">
            <option value="default" selected disabled hidden>All</option>
            <option value="0-10000">Price (Rs. 0-10000)</option>
            <option value="10000-20000">Price (Rs. 10000-20000)</option>
            <option value="20000-30000">Price (Rs. 20000-30000)</option>
            <option value="above 30000">Price (Above 30000)</option>
        </select>
    </div>
</div>
<div class="container" >
    <div>
        <table id="tableData" class="table table-bordered table-hover">
            <thead class="thead-dark">
            <tr>
                <th>Order Id</th>
                <th>Order Billno</th>
                <th>Order payreference</th>
                <th>Order total</th>
                <th>Payment Done On</th>
            </tr>
            </thead>
            <tbody>
            <% List<AdminViewPayments> payments = (List<AdminViewPayments>) request.getAttribute("payments");
                if(payments!=null){%>
                <% for (AdminViewPayments payment : payments) { %>
                    <tr>
                        <td><%= payment.getId() %></td>
                        <td><%= payment.getBillNumber()%></td>
                        <td><%= payment.getPaymentReference() %></td>
                        <td><%= payment.getTotal() %></td>
                        <td><%= payment.getOrderDate()%></td>
                    </tr>
                <% }}
                else
                {
                %>
                <tr>
                    <td colspan="5">No payments are there</td>
                </tr>
                <%} %>
            </tbody>
        </table>
    </div></div>
</div>
</body>
</html>
 