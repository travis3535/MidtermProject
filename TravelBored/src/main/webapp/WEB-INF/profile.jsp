<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
	<jsp:include page="subPages/styleIncludes.jsp"></jsp:include>
	<link rel="stylesheet" href="css/eventStyle.css">
	<link rel="stylesheet" href="css/profileStyle.css">
	<link rel="stylesheet" href="css/profileviewStyle.css">
	<script src="javascript/profileScript.js"></script>
	
</head>
<header>
  <jsp:include page="subPages/header.jsp"></jsp:include>
</header>

<body onload="showSection('${sectionNumber}')">

<div id="overlay">

<div class="update-event-class w3-card-4">
        <div>
          <div class="w3-container w3-2019-eden">
            <h2>Update Event</h2>
          </div>
          <form action="updateEvent.do" class="needs-validation" novalidate method="POST">
          <input id="updateId" type="hidden" name="id" value="${event.id }">
            <div class="form-group">
              <label for="title">Title:</label>
              <input type="text" class="w3-input form-control" id="updateTitle" placeholder="Enter title"   name="title" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="hook">Hook:</label>
              <input type="text" class="w3-input form-control" id="updateHook" placeholder="Enter hook"  name="hook" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="description">Description:</label>
              <input type="text" class="w3-input form-control" id="updateDescription" placeholder="Enter description"  name="description">
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="eventDate">Event Date:</label>
              <input type="date" class="w3-input form-control" id="updateDate" placeholder="Enter event date" name="eventDate" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="time">Time:</label>
              <input type="time" class="w3-input form-control" id="updateTime" placeholder="Enter time" name="eventTime" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="imgUrl">Photo URL:</label>
              <input type="url" class="w3-input form-control" id="updateImgUrl" placeholder="Enter photo URL" name="imgUrl" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="eventUrl">Event URL:</label>
              <input type="url" class="w3-input form-control" id="updateEventUrl" placeholder="Enter event URL" name="eventUrl">
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
            	<label for="location">Location:</label>
           	 	<select name="locationId" >
					<option id="locId" selected value="${sessionScope.loggedInUser.location.id}" ></option>
						<c:forEach var="location" items="${locations}">
							<option value="${location.id}" >${location.city} ${location.zipCode }</option>
						</c:forEach>
				</select>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
          </form>
          <button onclick="hideOverlay()" id="close-button">X</button>

        </div>
      </div>



</div>
<div id="group-overlay">

<div class="update-event-class w3-card-4">
        <div>
          <div class="w3-container w3-2019-eden">
            <h2>Update Group</h2>
          </div>
          <form action="updateGroup.do" class="needs-validation" novalidate method="POST">
          <input id="updateGroupId" type="hidden" name="id" value="${group.id }">
            <div class="form-group">
              <label for="title">Title:</label>
              <input type="text" class="w3-input form-control" id="updateGroupTitle" placeholder="Enter title"   name="title" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="hook">Hook:</label>
              <input type="text" class="w3-input form-control" id="updateGroupHook" placeholder="Enter hook"  name="hook" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
          </form>
          <button onclick="hideGroupOverlay()" id="close-button">X</button>

        </div>
      </div>



</div>



  <div class="container-fluid">
    <div class="row content">
      <div class="col-sm-2 blank-sidenav">
      
      </div>
      <div class="col-sm-2 sidenav">
        <ul class="sidenav nav-pills nav-stacked">
          <li class="active"><button onclick="showSection(1)">Profile</button></li>
          <li><button onclick="showSection(2)">Profile Settings</button></li>
          <li><button onclick="showSection(3)">Your Events</button></li>
          <li><button onclick="showSection(4)">Your Groups</button></li>
          <li><button onclick="showSection(5)">Your Photos</button></li>
        </ul><br>
      </div>
    <div class="col-sm-10">
    
      <div  id="section1">
<div class="card-container">
  <div class="card u-clearfix">
<img src="${sessionScope.loggedInUser.userImgUrl }" alt="" class="card-media" />
    <div class="card-body">
      <h2 class="card-title">${sessionScope.loggedInUser.username}</h2>
      <div class="card-read">   </div>
      <div class="card-read:after">
      <table>
      <c:forEach var="detail" items="${sessionScope.loggedInUser.userDetails}">
      <tr>
      <td>
      <c:if test="${empty detail.userDetailUrl}">
      <h3>${detail.userDetailName}:</h3>
      </c:if>
      <c:if test="${! empty detail.userDetailUrl}">
      <h3> <a href="${detail.userDetailUrl}">${detail.userDetailName}:</a></h3>
      </c:if>
      <p>${detail.userDetailDescription }</p>
      </td>
      <td>
      <form action="deleteUserDetail.do" method="post">
      <input type="hidden" value="${detail.id }" name="detailId">
      <button type="submit">Delete</button>
      </form>
      </td>
      </tr>
      </c:forEach>
      </table>
      <div class="w3-container w3-2019-eden">
            <h2>Add User Detail:</h2>
          </div>
          <form action="createUserDetail.do" class="needs-validation" novalidate method="POST">
            <div class="form-group">
              <label for="name">Detail Name:</label>
              <input type="text" class="w3-input form-control" id="username" placeholder="Enter name"  name="userDetailName" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="firstName">Description:</label>
              <input type="text" class="w3-input form-control" id="firstName" placeholder="Enter description" name="userDetailDescription" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="url">Detail URL:</label>
              <input type="url" class="w3-input form-control" id="lastName" placeholder="Link your detail" name="userDetailUrl" >
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <button type="submit" class="btn btn-primary">Add</button>
          </form>
      </div>
    </div>
    <div>
     <table class="table table-hover eventTable">
          <thead>
            <tr>
              <th>Event</th>
              <th>Hook</th>
            </tr>
          </thead>
          <tbody id="event-update-table">

            <c:forEach var="userEvent" items="${sessionScope.loggedInUser.userEvents}">
              <tr class="event-row">
                <td><a href="gotoEvent.do?eventId=${userEvent.event.id }">${userEvent.event.title}</a></td>
                <td>${userEvent.event.hook }</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
    </div>
   <div>
   <br><br>
     <table class="table table-hover eventTable">
          <thead>
            <tr>
              <th>Group</th>
              <th>Comment</th>
            </tr>
          </thead>
          <tbody id="event-update-table">
          <c:set var = "groupId" value="0"/> 
            <c:forEach var="comment" items="${groupComments}">
            <c:choose>
            <c:when test="${groupId != comment.group.id}">
              <tr class="event-row">
                <td><a href="gotoGroup.do?groupId=${comment.group.id }">${comment.group.title}</a></td>
                <td>${comment.content}</td>
              </tr>
            </c:when>
            <c:otherwise>
            <tr class="event-row">
                <td>&emsp; ^</td>
                <td>${comment.content}</td>
              </tr>
            </c:otherwise>
            </c:choose>
              <c:set var = "groupId" value="${comment.group.id }"/> 
            </c:forEach>
          </tbody>
        </table>
    </div>
  </div>
  <div class="card-shadow"></div>
</div>
</div>
      <div id="section2" class="w3-card-4">
        <div>
          <div class="w3-container w3-2019-eden">
            <h2>Update Account Information</h2>
          </div>
          <form action="updateProfile.do" class="needs-validation" novalidate method="POST">
            <div class="form-group">
              <label for="username">Screen Name:</label>
              <input type="text" class="w3-input form-control" id="username" placeholder="Enter screen name" value="${sessionScope.loggedInUser.username }"  name="username" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="firstName">First Name:</label>
              <input type="text" class="w3-input form-control" id="firstName" placeholder="Enter first name" value="${sessionScope.loggedInUser.firstName }" name="firstName" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="lastName">Last Name:</label>
              <input type="text" class="w3-input form-control" id="lastName" placeholder="Enter last name" value="${sessionScope.loggedInUser.lastName }" name="lastName" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="email">Email:</label>
              <input type="text" class="w3-input form-control" id="email" placeholder="Enter email" value="${sessionScope.loggedInUser.email }" name="email" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="password">Password:</label>
              <input type="password" class="w3-input form-control" id="password" placeholder="Enter password" name="password" required>
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
              <label for="userImgUrl">Profile Photo:</label>
              <input type="url" class="w3-input form-control" id="userImgUrl" placeholder="Your Photo Url here.." value="${sessionScope.loggedInUser.userImgUrl }"name="userImgUrl">
              <div class="valid-feedback">Valid.</div>
              <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
            	<label for="location">Location:</label>
           	 	<select name="locationId" required>
					<option selected value="${sessionScope.loggedInUser.location.id}" >${sessionScope.loggedInUser.location.city} ${sessionScope.loggedInUser.location.zipCode }</option>
					<c:forEach var="location" items="${locations}">
						<c:if test="${location.id !=  sessionScope.loggedInUser.location.id}">
							<option value="${location.id}" >${location.city} ${location.zipCode }</option>
						</c:if>
					</c:forEach>
				</select>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
          </form>

        </div>
      </div>
      <div id="section3">
        <table class="table table-hover eventTable">
          <thead>
            <tr>
              <th>Event</th>
              <th>Date</th>
              <th>Update</th>
            </tr>
          </thead>
          <tbody id="event-update-table">

            <c:forEach var="event" items="${creatorEvents}">
              <tr class="event-row">
                <td><a href="gotoEvent.do?eventId=${event.id }">${event.title}</a></td>
                <td><span class="glyphicon glyphicon-time"></span> ${event.createDate }</td>
                <%-- <input type="hidden" value="${event }" name = "event"> --%>
                <td><button onclick="showOverlay('${event.id}','<c:out value="${event.title }"/>', '<c:out value="${event.hook }"/>', '<c:out value="${event.description}"/>', '${event.eventDate}', '${event.eventTime}', '${event.imgUrl}', '${event.eventUrl}', '${event.location.id}', '${event.location.city}', '${event.location.zipCode}')">Update</button></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
      <div id="section4">
        <table class="table table-hover eventTable">
          <thead>
            <tr>
              <th>Group</th>
              <th>Date</th>
              <th>Active</th>
            </tr>
          </thead>
          <tbody id="group-update-table">

            <c:forEach var="group" items="${creatorGroups}">
              <tr class="event-row">
                <td><a href="gotoGroup.do?groupId=${group.id }">${group.title}</a></td>
                <td><span class="glyphicon glyphicon-time"></span> ${group.createDate }</td>
                <%-- <input type="hidden" value="${event }" name = "event"> --%>
                <td>${group.active }</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
      
      
      
      
      <div id="section5">
      
 <div id="demo" class="carousel slide" data-ride="carousel">

  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
    <li data-target="#demo" data-slide-to="1"></li>
    <li data-target="#demo" data-slide-to="2"></li>
    <li data-target="#demo" data-slide-to="3"></li>
    <li data-target="#demo" data-slide-to="4"></li>
    <li data-target="#demo" data-slide-to="5"></li>
  </ul>

  <!-- The slideshow -->
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="https://i.ibb.co/3rymx2F/cover2.jpg" alt="Los Angeles">
    </div>
    <div class="carousel-item">
      <img src="https://i.ibb.co/CbJFtnM/stock1.jpg" alt="Chicago">
    </div>
    <div class="carousel-item">
      <img src="https://i.ibb.co/3kQ2G6L/Isla-Mujeres.jpg" alt="New York">
    </div>
    <div class="carousel-item">
      <img src="https://i.ibb.co/HBv2y8S/switzerland.jpg">
    </div>
    <div class="carousel-item">
      <img src="https://i.ibb.co/y6dhsgt/water.jpg">
    </div>
    <div class="carousel-item">
      <img src="https://i.ibb.co/ZhKwmRf/420-marijuana-Denver-2017-rj-26379.jpg">
    </div>
  </div>


</div>
      
 
      
      
      
        
      </div>
      
      
    </div>
   </div>
  



</body>

</html>