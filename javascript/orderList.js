$('#dateRangeFilter').change(function() {
  applyFilters();
});

function showSpinner() {
  var spinnerContainer = document.getElementById('spinner-container');
  spinnerContainer.style.display = 'flex';
}

function hideSpinner() {
  var spinnerContainer = document.getElementById('spinner-container');
  spinnerContainer.style.display = 'none';
}
function applyFilters() {
  var dateRangeFilter = $('#dateRangeFilter').val();

  $('.order-row').each(function() {
    var orderRow = $(this);
    var orderDate = orderRow.find('td:eq(3)').text();
    var processedStatus = orderRow.find('td:eq(12) button').text();

    var showRow = true;

    if (dateRangeFilter !== 'All') {
      var currentDate = new Date();
      var orderDateObj = new Date(orderDate);

      if (dateRangeFilter === 'daily' && !isSameDate(currentDate, orderDateObj)) {
        showRow = false;
      } else if (dateRangeFilter === 'weekly' && !isSameWeek(currentDate, orderDateObj)) {
        showRow = false;
      } else if (dateRangeFilter === 'monthly' && !isSameMonth(currentDate, orderDateObj)) {
        showRow = false;
      }
    }

    if (showRow) {
      orderRow.show();
    } else {
      orderRow.hide();
    }
  });
}

function isSameDate(date1, date2) {
  return (
    date1.getFullYear() === date2.getFullYear() &&
    date1.getMonth() === date2.getMonth() &&
    date1.getDate() === date2.getDate()
  );
}

function isSameWeek(date1, date2) {
  var oneDay = 24 * 60 * 60 * 1000;
  var firstDayOfWeek = new Date(date1.getFullYear(), date1.getMonth(), date1.getDate() - date1.getDay());
  var firstDayOfNextWeek = new Date(firstDayOfWeek.getTime() + 7 * oneDay);
  return date2 >= firstDayOfWeek && date2 < firstDayOfNextWeek;
}

function isSameMonth(date1, date2) {
  return date1.getFullYear() === date2.getFullYear() && date1.getMonth() === date2.getMonth();
}

function processedStatusFilter() {
  var processedStatusFilter = $('#processedStatusFilter').val();

  if (processedStatusFilter === 'unprocessed') {
    // Call the function to retrieve unprocessed orders
    getUnprocessedOrders();
  } else {
    getProcessedOnlyOrders();
  }
}

function getUnprocessedOrders() {
showSpinner();
  // Send an AJAX request to retrieve unprocessed orders
  $.ajax({
    url: 'unprocessedOrders',
    method: 'GET',
    success: function(response) {
      // Handle the response and update the order list
      $('#content').html(response);
      hideSpinner();
    },
    error: function(xhr, status, error) {
      console.log('AJAX Error: ' + error);
    }
  });
}



function getProcessedOnlyOrders() {
showSpinner();
  // Send an AJAX request to retrieve processed orders
  $.ajax({
    url: 'processedOnlyOrders',
    method: 'GET',
    success: function(response) {
      // Handle the response and update the order list
      $('#content').html(response);
      hideSpinner();
    },
    error: function(xhr, status, error) {
      console.log('AJAX Error: ' + error);
    }
  });
}

var tokenElement = document.getElementById("tokenHolder");
var token = tokenElement.innerText;
// Use the "token" variable in your JavaScript code
console.log("Token: " + token);


function navigateToPage(page) {
showSpinner();
  var nextPage = parseInt(page) + 1;
  nextPage -= 1;
  console.log('in navigation next', nextPage);
  /*window.location.href = "/listOrders?page=" + nextPage;*/

  $.ajax({
    url: "listOrdersForPagination",
    method: 'GET',
    data: { nextPage: nextPage,
    token:token },
    success: function(response) {
      $('#content').html(response);
      hideSpinner();
    },
    error: function(xhr, status, error) {
      console.log('AJAX Error: ' + error);
    }
  });
}
