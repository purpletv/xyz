<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Details</title><link rel="stylesheet" href="path/to/your/custom.css"> <!-- Include your custom CSS file -->
   <link rel="stylesheet" type="text/css" href="./css/AddedCategory.css">

 
    <script src="./js/AddedCategory.js"></script>
</head>
<body>

<!-- Add this code snippet inside the <body> tag of your JSP page -->

<div id="trackOrderModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h3>Order Tracking</h3>
        <div class="shipment-status-line">
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
        </div>
        <div class="shipment-status-text">
            <div class="status">Order Placed</div>
            <div class="status">Order Processed</div>
            <div class="status">dispatched</div>
            <div class="status">Out for Delivery</div>
            <div class="status">Delivered</div>
        </div>
    </div>
</div>


<div id="cancelOrderModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h3>Your order has been cancelled</h3>
        <p>Insert any additional message or details here.</p>
    </div>
</div>

    <div class="container">
        <h2>Product Details</h2>
        <div class="product-card">
            <img class="card-img-top" src="${product. getImageUrl()}" alt="${product. getName()}">
            <div class="product-details">
                <div class="product-title">${product. getName()}</div>
                <div class="product-description">${product.getDescription()}</div>
                <%-- <div class="product-price">${product.getPrice()}</div> --%>
                <!-- Other product details as needed -->
                
                <c:if test="${product.getShipStat() != 'delivered' && product.getShipStat() != 'under processing'  && product.getShipStat() != 'cancelled' }">
                    <button class="btn btn-primary track-order-btn">Track Order</button>
                </c:if>
                <c:if test="${product.getShipStat() != 'delivered' && product.getShipStat()!='cancelled'}">
                    <button class="btn btn-danger cancel-order-btn">Cancel Order</button>
                </c:if>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    
    function displayModal(modalId) {
        var modal = document.getElementById(modalId);
        modal.style.display = "block";
    }

    // Function to close the modal
  function closeModal(modalId) {
        var modal = document.getElementById(modalId);
        modal.style.display = "none";
    }

    
        document.addEventListener('DOMContentLoaded', function () {
            var productDescription = document.querySelector('.product-description');
            var cancelOrderButton = document.querySelector('.cancel-order-btn');
            var trackOrderButtons = document.querySelectorAll('.track-order-btn');

            productDescription.addEventListener('click', function () {
                productDescription.classList.toggle('expanded');
                
            });
            
            $('.cancel-order-btn').click(function () {
                // Send an AJAX request to the server to cancel the order
                $.ajax({
                    url: 'cancelOrder', // Replace with your cancel order endpoint
                    type: 'POST',
                    data: { orderproId:${product. getId()} }, // Pass the order ID to the server
                    success: function (response) {
                        // Update the shipment status in the frontend (if necessary)
                        // Display the modal
                    	displayModal('cancelOrderModal');
                        
                       
                    },
                    error: function (xhr, status, error) {
                        // Handle any errors or display error message
                    }
                });
            });
            
            $('.track-order-btn').click(function () {
               
                  
                    
                    // Send an AJAX request to the server to retrieve the shipment status
                    $.ajax({
                        url: 'trackOrder',
                        type: 'GET',
                        data: { orderproId:${product. getId()} },
                        success: function (response) {
                            // Update the track order modal with the shipment status
                            var shipmentStatus = response;
                            console.log(shipmentStatus);
                            updateShipmentStatus(shipmentStatus);
                            
                            // Open the track order modal
                            displayModal('trackOrderModal');
                        },
                        error: function (xhr, status, error) {
                            // Handle the error case
                            console.log(error);
                        }
                    });
              
            });
            
            function updateShipmentStatus(shipmentStatus) {
                // Reset all dots to the default color
                $('.dot').css('background-color', 'gray');
                
                // Determine the index of the current shipment status
                var statusIndex;
                switch (shipmentStatus) {
                    case 'Order Placed':
                        statusIndex = 0;
                        break;
                    case 'Order Processed':
                        statusIndex = 1;
                        break;
                    case 'dispatched':
                        statusIndex = 2;
                        break;
                    case 'Out for Delivery':
                        statusIndex = 3;
                        break;
                    case 'Delivered':
                        statusIndex = 4;
                        break;
                    default:
                        statusIndex = -1; // Handle the case when shipment status is not recognized
                        break;
                }
                
                // Update the color of the corresponding dot
                if (statusIndex >= 0) {
                    $('.dot').eq(statusIndex).css('background-color', 'green');
                }
            }

            // Close the modal when the close button is clicked
            $('.close').click(function () {
                var modalId = $(this).closest('.modal').attr('id');
                closeModal(modalId);
            });
        });
    </script>
</body>
</html>
