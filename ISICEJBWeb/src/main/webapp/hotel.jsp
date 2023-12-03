<%@ page import="entities.Hotel" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map.Entry" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Hotels</title>
    <!-- Updated Bootstrap CSS link -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <!-- Custom styles -->
    <style>
        body {
            background-color: #f8f9fa; /* Light gray background */
        }

        .container {
            background-color: #ffffff; /* White container background */
            border-radius: 8px;
            padding: 20px;
            margin-top: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1, h2 {
            color: #007bff; /* Blue header text */
        }

        th {
            background-color: #007bff; /* Blue header background */
            color: #ffffff; /* White header text */
        }

        .form-group label {
            color: #007bff; /* Blue form label text */
        }

        .btn-primary {
            background-color: transparent; /* Transparent primary button */
            border-color: #007bff;
            color: #007bff; /* Blue text for transparent button */
        }

        .btn-warning {
            background-color: #28a745; /* Green warning button */
            border-color: #28a745;
        }

        .btn-danger {
            background-color: #dc3545; /* Red danger button */
            border-color: #dc3545;
        }

        .table {
            background-color: #ffffff; /* White table background */
        }

    </style>
</head>
<body>

<div class="container mt-3">
    <h1>Gestion des Hotels</h1>

    <form action="HotelController" method="post" class="mt-3">
        <div class="form-group">
            <label for="hotel">Nom :</label>
            <input type="text" name="hotel" id="hotel" class="form-control" required
                   value="${empty hotel ? '' : hotel.nom}" />
                    <label for="hotel">Ville :</label>
            <input type="text" name="ville" id="ville" class="form-control" />
        </div>

        <c:choose>
            <c:when test="${empty hotel}">
                <button type="submit" name="action" value="ajouter" class="btn btn-primary">Enregistrer</button>
            </c:when>
            <c:otherwise>
                <button type="submit" name="action" value="modifier" class="btn btn-warning">Modifier</button>
                <input type="hidden" name="id" value="${hotel.id}" />
            </c:otherwise>
        </c:choose>
    </form>

    <h2 class="mt-3">Liste des Hotels :</h2>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Ville</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${hotels}" var="v">
            <tr>
                <td>${v.id}</td>
                <td>${v.nom}</td>
                <td>${v.adresse}</td>
                <td>
                    <a href="#" onclick="modifierHotel(${v.id})" class="btn btn-warning btn-sm">Modifier</a>
                    <a href="#" onclick="confirmDelete(${v.id})" class="btn btn-danger btn-sm">Supprimer</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
<script>
    function confirmDelete(hotelId) {
        Swal.fire({
            title: 'Confirmation de suppression',
            text: 'Êtes-vous sûr de vouloir supprimer ce Hotel ?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Oui, supprimer',
            cancelButtonText: 'Annuler'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = 'HotelController?action=supprimer&id=' + hotelId;
            }
        });
    }
</script>
<h2 class="mt-3">Liste des Hotels par Ville :</h2>
<c:forEach var="h" items="${hotels}">
    
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Ville</th>
            <th>Actions</th>
            
        </tr>
        
        <tbody>
        
            <tr>
                <td>${h.id}</td>
                <td>${h.nom}</td>
                <td>${h.ville}</td>
                <td>
                    <a href="#" onclick="modifierHotel(${h.id})" class="btn btn-warning btn-sm">Modifier</a>
                    <a href="#" onclick="confirmDelete(${h.id})" class="btn btn-danger btn-sm">Supprimer</a>
                </td>
            </tr>
        
        </tbody>
        </thead>
    </table>
</c:forEach>


<script>
    function modifierHotel(hotelId) {
        window.location.href = 'HotelController?action=modifier&id=' + hotelId;
    }
</script>
</body>
</html>>